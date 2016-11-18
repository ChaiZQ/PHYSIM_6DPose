classdef CustomMsgConsts
    %CustomMsgConsts This class stores all message types
    %   The message types are constant properties, which in turn resolve
    %   to the strings of the actual types.
    
    %   Copyright 2016 The MathWorks, Inc.
    
    properties (Constant)
        detection_package_UpdateActiveListFrame = 'detection_package/UpdateActiveListFrame'
        detection_package_UpdateActiveListFrameRequest = 'detection_package/UpdateActiveListFrameRequest'
        detection_package_UpdateActiveListFrameResponse = 'detection_package/UpdateActiveListFrameResponse'
        detection_package_UpdateBbox = 'detection_package/UpdateBbox'
        detection_package_UpdateBboxRequest = 'detection_package/UpdateBboxRequest'
        detection_package_UpdateBboxResponse = 'detection_package/UpdateBboxResponse'
        pose_estimation_EstimateObjectPose = 'pose_estimation/EstimateObjectPose'
        pose_estimation_EstimateObjectPoseRequest = 'pose_estimation/EstimateObjectPoseRequest'
        pose_estimation_EstimateObjectPoseResponse = 'pose_estimation/EstimateObjectPoseResponse'
        pose_estimation_ObjectPose = 'pose_estimation/ObjectPose'
        realsense_camera_StreamSensor = 'realsense_camera/StreamSensor'
        realsense_camera_StreamSensorRequest = 'realsense_camera/StreamSensorRequest'
        realsense_camera_StreamSensorResponse = 'realsense_camera/StreamSensorResponse'
    end
    
    methods (Static, Hidden)
        function messageList = getMessageList
            %getMessageList Generate a cell array with all message types.
            %   The list will be sorted alphabetically.
            
            persistent msgList
            if isempty(msgList)
                msgList = cell(13, 1);
                msgList{1} = 'detection_package/UpdateActiveListFrame';
                msgList{2} = 'detection_package/UpdateActiveListFrameRequest';
                msgList{3} = 'detection_package/UpdateActiveListFrameResponse';
                msgList{4} = 'detection_package/UpdateBbox';
                msgList{5} = 'detection_package/UpdateBboxRequest';
                msgList{6} = 'detection_package/UpdateBboxResponse';
                msgList{7} = 'pose_estimation/EstimateObjectPose';
                msgList{8} = 'pose_estimation/EstimateObjectPoseRequest';
                msgList{9} = 'pose_estimation/EstimateObjectPoseResponse';
                msgList{10} = 'pose_estimation/ObjectPose';
                msgList{11} = 'realsense_camera/StreamSensor';
                msgList{12} = 'realsense_camera/StreamSensorRequest';
                msgList{13} = 'realsense_camera/StreamSensorResponse';
            end
            
            messageList = msgList;
        end
        
        function serviceList = getServiceList
            %getServiceList Generate a cell array with all service types.
            %   The list will be sorted alphabetically.
            
            persistent svcList
            if isempty(svcList)
                svcList = cell(4, 1);
                svcList{1} = 'detection_package/UpdateActiveListFrame';
                svcList{2} = 'detection_package/UpdateBbox';
                svcList{3} = 'pose_estimation/EstimateObjectPose';
                svcList{4} = 'realsense_camera/StreamSensor';
            end
            
            % The message list was already sorted, so don't need to sort
            % again.
            serviceList = svcList;
        end
    end
end