//
//  DCCamera.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "DCCamera.h"
#import "DCCaptureSession.h"
#import "DCCapturePreViewLayer.h"

@interface DCCamera () <DCCaptureSessionDelegate>

@property (nonatomic, strong) UIView                            *captureView;
@property (nonatomic, strong) DCCaptureSession                  *session;
@property (nonatomic, strong) DCCapturePreViewLayer             *previewLayer;

@end

@implementation DCCamera

+ (instancetype)cameraInCaptureView:(UIView *)captureView
{
    return [[self alloc] initWithCaptureView:captureView];
}

- (instancetype)initWithCaptureView:(UIView *)captureView
{
    self = [super init];
    if (self) {
        _session = [DCCaptureSession sessionWithDevicePosition:AVCaptureDevicePositionBack
                                                      delegate:self];
        _previewLayer = [DCCapturePreViewLayer previewLayerWithCaptureSession:_session
                                                                atCaptureView:captureView];
    }
    
    return self;
}

// MARK: ---- DCCaptureSessionDelegate Methods
// ------------------------------------------------------------------------------------------

- (void)capturePhotoFinished:(UIImage *)image
{
    [self.delegate takePhotoFinished:image];
}

// MARK: ---- Public Methods
// ------------------------------------------------------------------------------------------

- (void)startRunning
{
    [self.session startRunning];
}

- (void)stopRunning
{
    [self.session stopRunning];
}

- (void)takePhoto
{
    [self.session takePhotoWithVideoOrientation:AVCaptureVideoOrientationPortrait completion:^(UIImage * image) {
        [self.delegate takePhotoFinished:image];
    }];
}

- (BOOL)isFlashModeAvalibel
{
    return [self.session isFlashAvalible];
}

- (void)setFlashMode:(DCCameraFlashMode)flashMode
{
    [self.session setFlashMode:flashMode];
}


- (DCCameraFlashMode)changeFlashMode
{
    return [self.session changeFlashMode];
}

@end
