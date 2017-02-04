//
//  DCCaptureInputManager.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/31.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "DCCaptureInputManager.h"
#import "DCCaptureDeviceHelper.h"

@interface DCCaptureInputManager ()

@property (nonatomic, strong) AVCaptureDeviceInput       *input;
@property (nonatomic, strong) AVCaptureDevice            *device;

@end

@implementation DCCaptureInputManager

- (AVCaptureInput *)inputWithVideoType
{
    _device = [DCCaptureDeviceHelper deviceWithDefaultConfiguration];
    _input  = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
    
    return _input;
}

- (AVCaptureInput *)inputWithVideoTypeIn:(AVCaptureDevicePosition)devicePosition
{
    _device = [DCCaptureDeviceHelper deviceWithPosition:devicePosition];
    _input  = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
    
    return _input;
}


@end
