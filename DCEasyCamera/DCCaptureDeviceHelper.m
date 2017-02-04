//
//  DCCaptureDeviceHelper.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/31.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "DCCaptureDeviceHelper.h"

@implementation DCCaptureDeviceHelper

+ (AVCaptureDevice *)deviceWithDefaultConfiguration
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device lockForConfiguration:nil]) {
        // 对焦范围
        if (device.autoFocusRangeRestrictionSupported) {
            device.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
        }
        // 光滑对焦
        if (device.smoothAutoFocusSupported) {
            device.smoothAutoFocusEnabled = YES;
        }
        // 智能自动对焦
        if([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        }
        // 智能调整曝光
        device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        
        [device unlockForConfiguration];
    }
    
    return device;
}

+ (AVCaptureDevice *)deviceWithPosition:(AVCaptureDevicePosition)devicePosition
{
    
    NSArray *devices = nil;
    
#ifdef __IPHONE_10_0
    devices = [AVCaptureDeviceDiscoverySession
               discoverySessionWithDeviceTypes:@[
                                                 AVCaptureDeviceTypeBuiltInWideAngleCamera,
                                                 AVCaptureDeviceTypeBuiltInTelephotoCamera,
                                                 AVCaptureDeviceTypeBuiltInDuoCamera,
                                                 ]
               mediaType:AVMediaTypeVideo
               position:devicePosition].devices;
#else
    devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
#endif
    
    AVCaptureDevice *device;
    for (AVCaptureDevice *aDevice in devices) {
        if (aDevice.position == devicePosition) {
            device = aDevice;
        }
    }
    if (!device) {
        device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    if ([device lockForConfiguration:nil]) {
        if (device.autoFocusRangeRestrictionSupported) {
            device.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
        }
        if (device.smoothAutoFocusSupported) {
            device.smoothAutoFocusEnabled = YES;
        }
        if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        }
        device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        
        [device unlockForConfiguration];
    }
    
    return device;
}

@end
