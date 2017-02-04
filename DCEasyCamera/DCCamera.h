//
//  DCCamera.h
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DCCaptureSession.h"

@protocol DCCameraDelegate <NSObject>

- (void)takePhotoFinished:(UIImage *)photo;

@end

@interface DCCamera : NSObject

@property (nonatomic, strong) id<DCCameraDelegate>             delegate;

+ (instancetype)cameraInCaptureView:(UIView *)captureView;

- (void)startRunning;
- (void)stopRunning;

- (void)takePhoto;

// MARK: ---- Other Functions
// ------------------------------------------------------------------------------------------

- (BOOL)isFlashModeAvalibel;
- (void)setFlashMode:(DCCameraFlashMode)flashMode;

/**
 The order is DCCameraFlashModeOn -> DCCameraFlashModeOff -> DCCameraFlashModeAuto.
 Defule is DCCameraFlashModeOff.
 @return current flash mode
 */
- (DCCameraFlashMode)changeFlashMode;



@end
