//
//  DCCapturePreViewLayer.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "DCCapturePreViewLayer.h"

@implementation DCCapturePreViewLayer

+ (instancetype)previewLayerWithCaptureSession:(DCCaptureSession *)session
                                    atCaptureView:(UIView *)captureView
{
    return [[self alloc] initPreviewLayerWithCaptureSession:session atCaptureView:captureView];
}

- (instancetype)initPreviewLayerWithCaptureSession:(DCCaptureSession *)session
                                        atCaptureView:(UIView *)captureView
{
    self = [super initWithSession:session];
    if (self) {
        // video content mode
        self.videoGravity = AVLayerVideoGravityResizeAspectFill;
        captureView.layer.masksToBounds = YES;
        self.frame = captureView.frame;
        [captureView.layer insertSublayer:self atIndex:0];
    }
    
    return self;
}

@end
