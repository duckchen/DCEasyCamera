//
//  DCCaptureSession.h
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,DCCameraFlashMode)
{
    DCCameraFlashModeOn,
    DCCameraFlashModeOff,
    DCCameraFlashModeAuto
};

@protocol DCCaptureSessionDelegate <NSObject>

- (void)capturePhotoFinished:(UIImage *)image;

@end

@interface DCCaptureSession : AVCaptureSession

+ (instancetype)session;

+ (instancetype)sessionWithDevicePosition:(AVCaptureDevicePosition)devicePosition
                                 delegate:(id<DCCaptureSessionDelegate>)delegate;

// MARK: ---- Functions
// ------------------------------------------------------------------------------------------

// MARK: --- take photo ---
- (void)takePhotoWithVideoOrientation:(AVCaptureVideoOrientation)videoOrientation
                           completion:(void (^)(UIImage * image))completion;

// MARK: --- flash ---
- (BOOL)isFlashAvalible;
- (void)setFlashMode:(DCCameraFlashMode)flashMode;
// return current flash mode.
- (DCCameraFlashMode)changeFlashMode;

@end
