//
//  ViewController.m
//  DCEasyCamera
//
//  Created by 陈怀宇 on 16/12/27.
//  Copyright © 2016年 陈怀宇. All rights reserved.
//

#import "ViewController.h"
#import "DCCamera.h"

@interface ViewController () <DCCameraDelegate>

@property (nonatomic, strong) DCCamera             *camera;
@property (nonatomic, strong) UIImageView             *photoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    _camera = [DCCamera cameraInCaptureView:self.view];
    _camera.delegate = self;
    [_camera startRunning];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI
{
    
}

- (IBAction)captureButtonClicked:(id)sender {
    [self.camera takePhoto];
}

- (IBAction)flipButtonClicked:(id)sender {
    [self.camera flipCamera];
}

- (IBAction)flashButtonClicked:(id)sender {
    DCCameraFlashMode mode = [self.camera changeFlashMode];
    NSArray *nameList = @[@"flashlight_open", @"flashlight_close", @"flashlight_auto"];
    NSString *name = [nameList objectAtIndex:mode];
    [sender setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

// MARK: ---- DCCameraDelegate Methods
// ------------------------------------------------------------------------------------------

- (void)takePhotoFinished:(UIImage *)photo
{
    self.photoView.image = photo;
}

@end
