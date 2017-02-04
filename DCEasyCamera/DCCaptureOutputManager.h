//
//  DCCaptureOutputManager.h
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/31.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DCCaptureOutputManager : NSObject

#ifdef __IPHONE_10_0

- (AVCapturePhotoOutput *)output;

#else

- (AVCaptureStillImageOutput *)output;

#endif

- (AVCapturePhotoSettings *)photoSettings;

- (void)setFlashMode:(AVCaptureFlashMode)mode;
- (AVCaptureFlashMode)flashMode;

@end
