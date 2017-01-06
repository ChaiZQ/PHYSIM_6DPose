// Generated by gencpp from file pose_estimation/EstimateObjectPose.msg
// DO NOT EDIT!


#ifndef POSE_ESTIMATION_MESSAGE_ESTIMATEOBJECTPOSE_H
#define POSE_ESTIMATION_MESSAGE_ESTIMATEOBJECTPOSE_H

#include <ros/service_traits.h>


#include <pose_estimation/EstimateObjectPoseRequest.h>
#include <pose_estimation/EstimateObjectPoseResponse.h>


namespace pose_estimation
{

struct EstimateObjectPose
{

typedef EstimateObjectPoseRequest Request;
typedef EstimateObjectPoseResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct EstimateObjectPose
} // namespace pose_estimation


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::pose_estimation::EstimateObjectPose > {
  static const char* value()
  {
    return "828b8959ca98f06115ccafe45aef2e20";
  }

  static const char* value(const ::pose_estimation::EstimateObjectPose&) { return value(); }
};

template<>
struct DataType< ::pose_estimation::EstimateObjectPose > {
  static const char* value()
  {
    return "pose_estimation/EstimateObjectPose";
  }

  static const char* value(const ::pose_estimation::EstimateObjectPose&) { return value(); }
};


// service_traits::MD5Sum< ::pose_estimation::EstimateObjectPoseRequest> should match 
// service_traits::MD5Sum< ::pose_estimation::EstimateObjectPose > 
template<>
struct MD5Sum< ::pose_estimation::EstimateObjectPoseRequest>
{
  static const char* value()
  {
    return MD5Sum< ::pose_estimation::EstimateObjectPose >::value();
  }
  static const char* value(const ::pose_estimation::EstimateObjectPoseRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::pose_estimation::EstimateObjectPoseRequest> should match 
// service_traits::DataType< ::pose_estimation::EstimateObjectPose > 
template<>
struct DataType< ::pose_estimation::EstimateObjectPoseRequest>
{
  static const char* value()
  {
    return DataType< ::pose_estimation::EstimateObjectPose >::value();
  }
  static const char* value(const ::pose_estimation::EstimateObjectPoseRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::pose_estimation::EstimateObjectPoseResponse> should match 
// service_traits::MD5Sum< ::pose_estimation::EstimateObjectPose > 
template<>
struct MD5Sum< ::pose_estimation::EstimateObjectPoseResponse>
{
  static const char* value()
  {
    return MD5Sum< ::pose_estimation::EstimateObjectPose >::value();
  }
  static const char* value(const ::pose_estimation::EstimateObjectPoseResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::pose_estimation::EstimateObjectPoseResponse> should match 
// service_traits::DataType< ::pose_estimation::EstimateObjectPose > 
template<>
struct DataType< ::pose_estimation::EstimateObjectPoseResponse>
{
  static const char* value()
  {
    return DataType< ::pose_estimation::EstimateObjectPose >::value();
  }
  static const char* value(const ::pose_estimation::EstimateObjectPoseResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // POSE_ESTIMATION_MESSAGE_ESTIMATEOBJECTPOSE_H