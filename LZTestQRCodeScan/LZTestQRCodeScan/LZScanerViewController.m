//
//  LZScanerViewController.m
//  LZTestQRCodeScan
//
//  Created by comst on 16/4/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "LZScanerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LZScanerViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preViewLayer;
@end

@implementation LZScanerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self scanConfig];
    [self.session startRunning];
}

- (void)scanConfig{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat rectX;
    CGFloat rectY;
    CGFloat rectW = 200;
    CGFloat rectH = 200;
    
    rectX = ( screenW - rectW ) * 0.5;
    rectY = (screenH - rectH) * 0.5;
    
    self.output.rectOfInterest = CGRectMake(rectY / screenH, rectX / screenW, rectH / screenH, rectW / screenW);
    
    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1920x1080]){
        [self.session setSessionPreset:AVCaptureSessionPreset1920x1080];
    }else if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]){
        [self.session setSessionPreset:AVCaptureSessionPreset1280x720];
    }else{
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }
    
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    self.preViewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preViewLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:self.preViewLayer atIndex:0];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [self.session stopRunning];
    if (metadataObjects.count <= 0) {
        NSLog(@"no QRCode");
        return;
    }else{
        AVMetadataMachineReadableCodeObject *item = [metadataObjects lastObject];
       
        UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:@"result" message:item.stringValue preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.session startRunning];
        }];
        [alerVc addAction:action];
        [self presentViewController:alerVc animated:YES completion:nil];
    }
}























@end
