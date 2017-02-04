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
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    UIButton * captureButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 32, kScreenHeight - 100, 64, 64)];
    [captureButton setBackgroundColor:[UIColor redColor]];
    [captureButton addTarget:self action:@selector(captureButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captureButton];
    
    UIButton * flashButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 32, 32)];
    [flashButton addTarget:self action:@selector(flashButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [flashButton setImage:[UIImage imageNamed:@"flashlight_close"] forState:UIControlStateNormal];
    [self.view addSubview:flashButton];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, kScreenHeight - 144, 100, 100)];
    _photoView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
}

// take photo
- (void)captureButtonTouched
{
    [self.camera takePhoto];
}

// flash
- (void)flashButtonTouched:(UIButton *)sender
{
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
