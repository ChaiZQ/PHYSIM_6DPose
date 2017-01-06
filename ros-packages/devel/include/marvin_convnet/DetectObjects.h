// Generated by gencpp from file marvin_convnet/DetectObjects.msg
// DO NOT EDIT!


#ifndef MARVIN_CONVNET_MESSAGE_DETECTOBJECTS_H
#define MARVIN_CONVNET_MESSAGE_DETECTOBJECTS_H

#include <ros/service_traits.h>


#include <marvin_convnet/DetectObjectsRequest.h>
#include <marvin_convnet/DetectObjectsResponse.h>


namespace marvin_convnet
{

struct DetectObjects
{

typedef DetectObjectsRequest Request;
typedef DetectObjectsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct DetectObjects
} // namespace marvin_convnet


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::marvin_convnet::DetectObjects > {
  static const char* value()
  {
    return "deaeaba672c95d5138aecb89dd9fc829";
  }

  static const char* value(const ::marvin_convnet::DetectObjects&) { return value(); }
};

template<>
struct DataType< ::marvin_convnet::DetectObjects > {
  static const char* value()
  {
    return "marvin_convnet/DetectObjects";
  }

  static const char* value(const ::marvin_convnet::DetectObjects&) { return value(); }
};


// service_traits::MD5Sum< ::marvin_convnet::DetectObjectsRequest> should match 
// service_traits::MD5Sum< ::marvin_convnet::DetectObjects > 
template<>
struct MD5Sum< ::marvin_convnet::DetectObjectsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::marvin_convnet::DetectObjects >::value();
  }
  static const char* value(const ::marvin_convnet::DetectObjectsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::marvin_convnet::DetectObjectsRequest> should match 
// service_traits::DataType< ::marvin_convnet::DetectObjects > 
template<>
struct DataType< ::marvin_convnet::DetectObjectsRequest>
{
  static const char* value()
  {
    return DataType< ::marvin_convnet::DetectObjects >::value();
  }
  static const char* value(const ::marvin_convnet::DetectObjectsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::marvin_convnet::DetectObjectsResponse> should match 
// service_traits::MD5Sum< ::marvin_convnet::DetectObjects > 
template<>
struct MD5Sum< ::marvin_convnet::DetectObjectsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::marvin_convnet::DetectObjects >::value();
  }
  static const char* value(const ::marvin_convnet::DetectObjectsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::marvin_convnet::DetectObjectsResponse> should match 
// service_traits::DataType< ::marvin_convnet::DetectObjects > 
template<>
struct DataType< ::marvin_convnet::DetectObjectsResponse>
{
  static const char* value()
  {
    return DataType< ::marvin_convnet::DetectObjects >::value();
  }
  static const char* value(const ::marvin_convnet::DetectObjectsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // MARVIN_CONVNET_MESSAGE_DETECTOBJECTS_H