function resp = poseServiceIterative(~, reqMsg, respMsg)

timerval = tic;

global objModels;
global objNames;
global calibBin;
global usePhysics;
global SegMode;
global InitPoseMode;
global debugOption;
global useSceneOptimizer;

frames = [];

% Objects
apc_objects_strs = containers.Map(...
 {'crayola_24_ct', 'expo_dry_erase_board_eraser', 'folgers_classic_roast_coffee',...
  'scotch_duct_tape', 'dasani_water_bottle', 'jane_eyre_dvd',...
  'up_glucose_bottle', 'laugh_out_loud_joke_book', 'soft_white_lightbulb',...
  'kleenex_tissue_box', 'ticonderoga_12_pencils', 'dove_beauty_bar',...
  'dr_browns_bottle_brush', 'elmers_washable_no_run_school_glue', 'rawlings_baseball',...
  'command_hooks', 'kyjen_squeakin_eggs_plush_puppies', 'platinum_pets_dog_bowl', 'cherokee_easy_tee_shirt'...
},{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19});

% Path configurations
repo_path = getenv('PHYSIM_6DPose_PATH');
toolboxPath = repo_path; % Directory of toolbox utilities
tmpDataPath = strcat(repo_path,'/tmp');

inPHYSIM = strcat(repo_path,'/tmp/init_pose.txt');
outPHYSIM = strcat(repo_path,'/tmp/final_pose.txt');
allInitPose = strcat(repo_path,'/tmp/allInitPose.txt');

% Add paths and create directories
addpath(genpath(fullfile(toolboxPath,'ros-packages/src/rgbd-utils')));

scenePath = reqMsg.SceneFiles; % Directory holding the RGB-D data of scene
calibPath = reqMsg.CalibrationFiles; % Directory holding camera pose calibration of scene

% Remove all files in temporary folder used by marvin_convnet
if exist(fullfile(tmpDataPath,'raw'),'file')
    rmdir(fullfile(tmpDataPath,'raw'),'s');
end
if exist(fullfile(tmpDataPath,'results'),'file')
    rmdir(fullfile(tmpDataPath,'results'),'s');
end
if exist(fullfile(tmpDataPath,'masks'),'file')
    rmdir(fullfile(tmpDataPath,'masks'),'s');
end
if exist(fullfile(tmpDataPath,'segm'),'file')
    rmdir(fullfile(tmpDataPath,'segm'),'s');
end
if exist(fullfile(tmpDataPath,'bbox_detections'),'file')
    rmdir(fullfile(tmpDataPath,'bbox_detections'),'s');
end
delete(fullfile(tmpDataPath,'*'));

% Copy current scene to temporary folder used by marvin_convnet
if exist(fullfile(scenePath,'bbox_detections'),'file')
    rmdir(fullfile(scenePath,'bbox_detections'),'s');
end

copyfile(fullfile(scenePath,'*'),tmpDataPath);

% Load scene data
fprintf('\n[Processing] Loading scene RGB-D dataa\n');
sceneData = loadScene(tmpDataPath);
numFrames = length(sceneData.colorFrames);

% Calibrate scene
if calibBin == 1
    sceneData = loadCalib(calibPath,sceneData);
end

% Fill holes in depth frames for scene
camposefile = fopen(fullfile(tmpDataPath,'cam_pose.txt'),'wt');
for frameIdx = 1:length(sceneData.depthFrames)
    sceneData.depthFrames{frameIdx} = fillHoles(sceneData.depthFrames{frameIdx});
    frames = [frames,frameIdx];
    campose = sceneData.extCam2World{frames(1,frameIdx)};
    initrot1 = [-1,0,0; 0,1,0; 0,0,-1];
    initrot2 = [-1,0,0; 0,-1,0; 0,0,1];
    camrot = campose(1:3,1:3)*initrot1*initrot2;

    fprintf(camposefile, '%f %f %f %f %f %f %f %f %f %f %f %f\n', ...
                camrot(1,1), camrot(1,2), camrot(1,3), campose(1,4), ...
                camrot(2,1), camrot(2,2), camrot(2,3), campose(2,4), ...
                camrot(3,1), camrot(3,2), camrot(3,3), campose(3,4) ...
            );
end

% Call Segmentaion module
if strcmp(SegMode,'rcnn') == 1 
    getRCNNSegmentation(sceneData, scenePath, tmpDataPath, apc_objects_strs, frames, numFrames);
elseif strcmp(SegMode,'fcn') == 1 
    getFCNSegmentation(sceneData, scenePath, tmpDataPath, apc_objects_strs, frames, numFrames);
elseif strcmp(SegMode == 'gt') == 1
    getGTBBoxSegmentation(sceneData, scenePath, tmpDataPath, apc_objects_strs, frames, numFrames, objNames);
end

% Get Initial Pairwise registrarion
allfp = fopen(allInitPose, 'wt');
% Iterate over each Object in Scene
for obIdx = 1:size(sceneData.objects,2)
    objName = sceneData.objects{obIdx};
    try
        % Read object segmented cloud, model data        
        pclname = sprintf('seg-no-color-%s.ply',objName);
        pclname = fullfile(scenePath, pclname);
        objSegCloud = pcread(pclname);

        objModel = objModels{find(ismember(objNames,objName))};
        objModelPts = getModelPoints(sceneData, objModels, objModel);

        % Get Initialization Pose
        fprintf('\n[Processing] Getting Init Pose for %s\n', objName);

        if strcmp(InitPoseMode,'super4pcs') == 1 
            bestpredObjPoseBin = getInitPoseSuper4PCS(scenePath, sceneData, objNames, objModels, obIdx, objSegCloud, objModelPts,...
                                             objModel, inPHYSIM, outPHYSIM);
        elseif strcmp(InitPoseMode,'pca') == 1
            bestpredObjPoseBin = getInitPosePCA(scenePath, sceneData, objNames, objModels, obIdx, objSegCloud, objModelPts,...
                                             objModel, inPHYSIM, outPHYSIM);
        elseif strcmp(InitPoseMode,'fgr') == 1
            bestpredObjPoseBin = getInitPoseFGR(scenePath, sceneData, objNames, objModels, obIdx, objSegCloud, objModelPts,...
                                             objModel, inPHYSIM, outPHYSIM);
        end
        fprintf('[Processing] Init Pose Done\n');
        
        % bestpredObjPoseBin(1,4) = bestpredObjPoseBin(1,4) + 0.02;
        % bestpredObjPoseBin(2,4) = bestpredObjPoseBin(2,4) + 0.02;

        predObjPoseWorld = sceneData.extBin2World * bestpredObjPoseBin;

        % Debug : visualize model points in transformed pose
        if debugOption == 1
            tmpObjModelPts = bestpredObjPoseBin(1:3,1:3) * objModelPts + repmat(bestpredObjPoseBin(1:3,4),1,size(objModelPts,2));
            tmpObjModelCloud = pointCloud(tmpObjModelPts');
            pclname = sprintf('before-physics-%s',objName);
            pclname = fullfile(scenePath, pclname);

            poseT = zeros(4,4);
            quat = rotm2quat(bestpredObjPoseBin(1:3,1:3));
            rotm = quat2rotm(quat);
            poseT(1:3,1:3) = rotm';
            poseT(4,4) = 1;
            poseT(4,1:3) =  bestpredObjPoseBin(1:3,4)';

            tform = affine3d(poseT);
            objModelTrans = pctransform(objModel, tform);

            % pcwrite(tmpObjModelCloud,pclname,'PLYFormat','binary');
            pcwrite(objModelTrans,pclname,'PLYFormat','binary')
        end

        % Write Poses to a file
        fprintf(allfp, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n', ...
                objName, ...
                predObjPoseWorld(1,1), predObjPoseWorld(1,2), predObjPoseWorld(1,3), predObjPoseWorld(1,4), ...
                predObjPoseWorld(2,1), predObjPoseWorld(2,2), predObjPoseWorld(2,3), predObjPoseWorld(2,4), ...
                predObjPoseWorld(3,1), predObjPoseWorld(3,2), predObjPoseWorld(3,3), predObjPoseWorld(3,4), ...
                sceneData.extBin2World(1,4), sceneData.extBin2World(2,4), sceneData.extBin2World(3,4) ...
            );
    catch
        fprintf('Returning default pose');
        fprintf(allfp, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n', ...
                objName, ...
                1, 0, 0, 0, ...
                0, 1, 0, 0, ...
                0, 0, 1, 0, ...
                sceneData.extBin2World(1,4), sceneData.extBin2World(2,4), sceneData.extBin2World(3,4) ...
            );
    end
end
fclose(allfp);
copyfile(allInitPose,inPHYSIM);


% Use physics to correct final poses. This uses local iterative optimization wrt to ICP and phyical consistency.
if usePhysics == 1
    runPhyTrimICP(inPHYSIM, outPHYSIM, objNames, objModels, sceneData, scenePath);
    [objName, val1, val2, val3, val4, ...
     val5, val6, val7, val8, ...
     val9, val10, val11, val12, val13, val14, val15] = textread(outPHYSIM, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n');
else
    [objName, val1, val2, val3, val4, ...
     val5, val6, val7, val8, ...
     val9, val10, val11, val12, val13, val14, val15] = textread(inPHYSIM, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n');
end

if useSceneOptimizer == 1
    runSceneOptimizer(allInitPose, inPHYSIM, outPHYSIM, objNames, objModels, sceneData, scenePath);
    [objName, val1, val2, val3, val4, ...
     val5, val6, val7, val8, ...
     val9, val10, val11, val12, val13, val14, val15] = textread(inPHYSIM, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n');
end

% Write poses to rosmessage
for obIdx = 1:size(sceneData.objects,2)
    predObjPoseWorld = zeros(4,4);

    predObjPoseWorld(1,1) = val1(obIdx,1);
    predObjPoseWorld(1,2) = val2(obIdx,1);
    predObjPoseWorld(1,3) = val3(obIdx,1);
    predObjPoseWorld(1,4) = val4(obIdx,1);
    predObjPoseWorld(2,1) = val5(obIdx,1);
    predObjPoseWorld(2,2) = val6(obIdx,1);
    predObjPoseWorld(2,3) = val7(obIdx,1);
    predObjPoseWorld(2,4) = val8(obIdx,1);
    predObjPoseWorld(3,1) = val9(obIdx,1);
    predObjPoseWorld(3,2) = val10(obIdx,1);
    predObjPoseWorld(3,3) = val11(obIdx,1);
    predObjPoseWorld(3,4) = val12(obIdx,1);
    predObjPoseWorld(4,4) = 1;

    % Debug : visualize the pose after using physics
    if (usePhysics == 1 || useSceneOptimizer == 1) && (debugOption == 1)
        binpose = inv(sceneData.extBin2World) * predObjPoseWorld;
        objNameR = sceneData.objects{obIdx};
        objModel = objModels{find(ismember(objNames,objNameR))};

        pclname = sprintf('after-physics-%s',objNameR);
        pclname = fullfile(scenePath, pclname);
        poseT = zeros(4,4);
        quat = rotm2quat(binpose(1:3,1:3));
        rotm = quat2rotm(quat);
        poseT(1:3,1:3) = rotm';
        poseT(4,4) = 1;
        poseT(4,1:3) =  binpose(1:3,4)';

        tform = affine3d(poseT);
        objModelTrans = pctransform(objModel, tform);

        pcwrite(objModelTrans,pclname,'PLYFormat','binary')
    end

    poseTrans = rosmessage('geometry_msgs/Point');
    poseTrans.X = predObjPoseWorld(1,4);
    poseTrans.Y = predObjPoseWorld(2,4);
    poseTrans.Z = predObjPoseWorld(3,4);
    poseRot = rosmessage('geometry_msgs/Quaternion');
    poseQuat = rotm2quat(predObjPoseWorld(1:3,1:3));
    poseRot.X = poseQuat(2);
    poseRot.Y = poseQuat(3);
    poseRot.Z = poseQuat(4);
    poseRot.W = poseQuat(1);
    poseMsg = rosmessage('geometry_msgs/Pose');

    poseMsg.Position = poseTrans;
    poseMsg.Orientation = poseRot;

    CurobjectPose = rosmessage('pose_estimation/ObjectPose');
    CurobjectPose.Pose = poseMsg;

    CurobjectPose.Label = char(objName{obIdx,1});

    respMsg.Objects = [respMsg.Objects; CurobjectPose];
end

toc(timerval);

resp = true;
showdetails(respMsg);
end
