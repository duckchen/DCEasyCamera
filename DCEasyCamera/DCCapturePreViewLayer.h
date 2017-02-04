//
//  DCCapturePreViewLayer.h
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "DCCaptureSession.h"

@interface DCCapturePreViewLayer : AVCaptureVideoPreviewLayer

+ (instancetype)previewLayerWithCaptureSession:(DCCaptureSession *)session
                                 atCaptureView:(UIView *)captureView;

@end
