//
//  DCCaptureSession.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "DCCaptureSession.h"
#import "DCCaptureInputManager.h"
#import "DCCaptureOutputManager.h"

@interface DCCaptureSession () <AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) id<DCCaptureSessionDelegate>             delegate;
@property (nonatomic, strong) DCCaptureInputManager           *inputManager;
@property (nonatomic, strong) DCCaptureOutputManager          *outputManager;

@end

@implementation DCCaptureSession

// MARK: ---- Getter Methods
// ------------------------------------------------------------------------------------------

- (DCCaptureInputManager *)inputManager
{
    if (_inputManager == nil) {
        _inputManager = [DCCaptureInputManager new];
    }
    
    return _inputManager;
}

- (DCCaptureOutputManager *)outputManager
{
    if (_outputManager == nil) {
        _outputManager = [DCCaptureOutputManager new];
    }
    
    return _outputManager;
}

+ (instancetype)new
{
    DCCaptureSession * session = [super new];
    if (session) {
        session.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    return session;
}

+ (instancetype)session
{
    DCCaptureSession * session = [self.class new];
    [session addInput:[session.inputManager inputWithVideoType]];
    
    return session;
}

+ (instancetype)sessionWithDevicePosition:(AVCaptureDevicePosition)devicePosition
                                 delegate:(id<DCCaptureSessionDelegate>)delegate
{
    DCCaptureSession * session = [self.class new];
    [session addInput:[session.inputManager inputWithVideoTypeIn:devicePosition]];
    [session addOutput:[session.outputManager output]];
    session.delegate = delegate;
    
    return session;
}

// MARK: ---- AVCapturePhotoCaptureDelegate
// ------------------------------------------------------------------------------------------

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput
didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer
previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer
     resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings
      bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings
                error:(NSError *)error
{
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        // TODO: This is the image we captured. Need callback.
        UIImage *image = [UIImage imageWithData:data];
        [self.delegate capturePhotoFinished:image];
    }
}

// MARK: ---- Public Methods
// ------------------------------------------------------------------------------------------

- (void)takePhotoWithVideoOrientation:(AVCaptureVideoOrientation)videoOrientation
                           completion:(void (^)(UIImage * image))completion
{
    if ([[_outputManager output] isKindOfClass:[AVCapturePhotoOutput class]]) {
        AVCapturePhotoOutput *photoOutput = [_outputManager output];
        AVCapturePhotoSettings *settings = [self.outputManager photoSettings];
        [photoOutput capturePhotoWithSettings:settings delegate:self];
        
    } else if ([[_outputManager output] isKindOfClass:[AVCaptureStillImageOutput class]]) {
        AVCaptureConnection *videoConnection = nil;
        AVCaptureStillImageOutput *stillImageOutput = (AVCaptureStillImageOutput *)[_outputManager output];
        for (AVCaptureConnection *connection in [stillImageOutput connections]) {
            for (AVCaptureInputPort *port in [connection inputPorts]) {
                if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                    videoConnection = connection;
                    break;
                }
            }
            
            if (videoConnection) {
                break;
            }
        }
        
        [videoConnection setVideoOrientation:videoOrientation];
        
        [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                      completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                          if (imageDataSampleBuffer != NULL) {
                                                              NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                              UIImage *image = [UIImage imageWithData:imageData];
                                                              completion(image);
                                                          }
                                                      }];
    }
}

- (BOOL)isFlashAvalible
{
    AVCaptureDevice *device = [self.inputs.lastObject device];
    return [device isFlashAvailable];
}

- (void)setFlashMode:(DCCameraFlashMode)flashMode
{
    AVCaptureFlashMode mode;
    switch (flashMode) {
        case DCCameraFlashModeOn: {
            mode = AVCaptureFlashModeOn;
           break;
        }
        case DCCameraFlashModeOff: {
            mode = AVCaptureFlashModeOff;
            break;
        }
        case DCCameraFlashModeAuto: {
            mode = AVCaptureFlashModeAuto;
            break;
        }
        default:
            break;
    }
#ifdef __IPHONE_10_0
    
    [self.outputManager setFlashMode:mode];
    
#else
    AVCaptureDevice *device = [self.inputs.lastObject device];
    [device lockForConfiguration:nil];
    if ([device isFlashModeSupported:mode]) {
        device.flashMode = mode;
    }
    [device unlockForConfiguration];
#endif
}

- (DCCameraFlashMode)changeFlashMode
{
    AVCaptureFlashMode flashMode;
#ifdef __IPHONE_10_0
    flashMode = [self.outputManager flashMode];
#else
    AVCaptureDevice *device = [self.inputs.lastObject device];
    [device lockForConfiguration:nil];
    flashMode = [device flashMode];
    [device unlockForConfiguration];
#endif
    DCCameraFlashMode DCFlashMode;
    switch (flashMode) {
        case AVCaptureFlashModeOn: {
            DCFlashMode = DCCameraFlashModeOff;
            break;
        }
        case AVCaptureFlashModeOff: {
            DCFlashMode = DCCameraFlashModeAuto;
            break;
        }
        case AVCaptureFlashModeAuto: {
            DCFlashMode = DCCameraFlashModeOn;
            break;
        }
        default:
            break;
    }
    
    [self setFlashMode:DCFlashMode];
    return DCFlashMode;
}

@end
