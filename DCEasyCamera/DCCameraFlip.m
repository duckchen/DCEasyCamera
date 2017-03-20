//
//  DCCameraFlip.m
//  DCEasyCamera
//
//  Created by chy on 17/3/20.
//  Copyright © 2017年 陈怀宇. All rights reserved.
//

#import "DCCameraFlip.h"
#import <Photos/Photos.h>

@implementation DCCameraFlip

+ (void)flipWithCaptureSession:(AVCaptureSession *)session
{
    AVCaptureDeviceInput *deviceInput = [session.inputs lastObject];
    AVCaptureDeviceInput *reverseDeviceInput = [self reverseDeviceInput:deviceInput];
    
    [session beginConfiguration];
    [session removeInput:deviceInput];
    [session addInput:reverseDeviceInput];
    [session commitConfiguration];
}

#pragma mark -
#pragma mark - Private methods

+ (AVCaptureDeviceInput *)reverseDeviceInput:(AVCaptureDeviceInput *)deviceInput
{
    //
    // reverse device position
    //
    
    AVCaptureDevicePosition reversePosition;
    
    if ([deviceInput.device position] == AVCaptureDevicePositionFront) {
        reversePosition = AVCaptureDevicePositionBack;
    } else {
        reversePosition = AVCaptureDevicePositionFront;
    }
    
    //
    // find device with reverse position
    //
    NSArray *devices = [AVCaptureDeviceDiscoverySession
                        discoverySessionWithDeviceTypes:@[
                                                          AVCaptureDeviceTypeBuiltInWideAngleCamera,
                                                          AVCaptureDeviceTypeBuiltInTelephotoCamera,
                                                          AVCaptureDeviceTypeBuiltInDuoCamera,
                                                          ]
                        mediaType:AVMediaTypeVideo position:reversePosition].devices;
    AVCaptureDevice *reverseDevice = nil;
    
    for (AVCaptureDevice *device in devices) {
        if ([device position] == reversePosition) {
            reverseDevice = device;
            break;
        }
    }
    
    //
    // reverse device input
    //
    
    return  [AVCaptureDeviceInput deviceInputWithDevice:reverseDevice error:nil];
}


@end
