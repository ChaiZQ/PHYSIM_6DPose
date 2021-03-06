function scenePointCloud = getScenePointCloud(sceneData,gridStep)
% Project RGB-D data of a scene into 3D space to create a point cloud
%
% function scenePointCloud = getScenePointCloud(sceneData,gridStep)
% Input:
%   sceneData       - data structure holding camera information and a
%                     sequence of RGB-D frames of a scene
%   gridStep        - Kernel size for the grid filter of the point cloud.
%                     A.k.a. the "resolution" of the point cloud in meters
% Output:
%   scenePointCloud - data structure holding the reconstructed point cloud
%                     of the scene from the RGB-D data
%
% ---------------------------------------------------------
% Copyright (c) 2016, Andy Zeng
% 
% This file is part of the APC Vision Toolbox and is available 
% under the terms of the Simplified BSD License provided in 
% LICENSE. Please retain this notice and LICENSE if you use 
% this file (or any portion of it) in your project.
% ---------------------------------------------------------

global binBounds;
global tableBounds;

if ~exist('gridStep','var')
    gridStep = 0.001;
end

% Create aggregated RGB-D point cloud
numFrames = length(sceneData.colorFrames);
for frameIdx = 1:numFrames
    colorFrame = sceneData.colorFrames{frameIdx};
    depthFrame = sceneData.depthFrames{frameIdx};
    extCam2World = sceneData.extCam2World{frameIdx};

    % Project depth into camera space
    [pixX,pixY] = meshgrid(1:640,1:480);
    camX = (pixX-sceneData.colorK(1,3)).*depthFrame/sceneData.colorK(1,1);
    camY = (pixY-sceneData.colorK(2,3)).*depthFrame/sceneData.colorK(2,2);
    camZ = depthFrame;

    % Only use points with valid depth
    validDepth = find((camZ > 0));
    camPts = [single(camX(validDepth)),single(camY(validDepth)),single(camZ(validDepth))]';

    % Convert to bin coordinate space
    camPts = extCam2World(1:3,1:3) * camPts + repmat(extCam2World(1:3,4),1,size(camPts,2));
    
    % Get vertex colors
    colorR = colorFrame(:,:,1);
    colorG = colorFrame(:,:,2);
    colorB = colorFrame(:,:,3);
    colorPts = [colorR(validDepth),colorG(validDepth),colorB(validDepth)]';

    % Aggregate point clouds
    if frameIdx == 1
      camPointCloud = pointCloud(camPts','Color',colorPts');
    else
      camPointCloud = pcmerge(camPointCloud,pointCloud(camPts','Color',colorPts'),gridStep);
    end
end
% Downsample point cloud
scenePointCloud = pcdownsample(camPointCloud,'gridAverage',gridStep);
end

