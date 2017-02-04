//
//  DCCaptureOutputManager.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/31.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "DCCaptureOutputManager.h"

@interface DCCaptureOutputManager ()

#ifdef __IPHONE_10_0

@property (nonatomic, strong) AVCapturePhotoOutput             *photoOutput;

#else

@property (nonatomic, strong) AVCaptureStillImageOutput        *photoOutput;

#endif

@property (nonatomic, assign) AVCaptureFlashMode                flashMode;

@end

@implementation DCCaptureOutputManager

// MARK: ---- Getter
// ------------------------------------------------------------------------------------------
#ifdef __IPHONE_10_0

- (AVCapturePhotoOutput *)photoOutput
{
    if (_photoOutput == nil) {
        _photoOutput = [AVCapturePhotoOutput new];
    }
    
    return _photoOutput;
}

#else

- (AVCaptureStillImageOutput *)photoOutput
{
    if (_photoOutput == nil) {
        NSDictionary *outputSettings = [NSDictionary
                                        dictionaryWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
        _photoOutput = [AVCaptureStillImageOutput new];
        _photoOutput.outputSettings = outputSettings;
    }
    
    return _photoOutput;
}

#endif

// MARK: ---- Private Methods
// ------------------------------------------------------------------------------------------


// MARK: ---- Public Methods
// ------------------------------------------------------------------------------------------

#ifdef __IPHONE_10_0

- (AVCapturePhotoOutput *)output
{
    return self.photoOutput;
}

#else

- (AVCaptureStillImageOutput *)output
{
    return self.photoOutput;
}

#endif

- (AVCapturePhotoSettings *)photoSettings
{
    AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettings];
    [photoSettings setFlashMode:self.flashMode];
    
    return photoSettings;
}

- (void)setFlashMode:(AVCaptureFlashMode)mode
{
    _flashMode = mode;
}

@end
