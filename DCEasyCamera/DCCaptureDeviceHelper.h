//
//  DCCaptureDeviceHelper.h
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/31.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DCCaptureDeviceHelper : NSObject

+ (AVCaptureDevice *)deviceWithDefaultConfiguration;

+ (AVCaptureDevice *)deviceWithPosition:(AVCaptureDevicePosition)devicePosition;

@end
