//
//  DCCameraFlip.h
//  DCEasyCamera
//
//  Created by chy on 17/3/20.
//  Copyright © 2017年 陈怀宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVCaptureSession;

@interface DCCameraFlip : NSObject

+ (void)flipWithCaptureSession:(AVCaptureSession *)session;

@end
