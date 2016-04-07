//
//  ViewController.m
//  LZTestQRCodeScan
//
//  Created by comst on 16/4/5.
//  Copyright © 2016年 com.comst1314. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)fromAlbumAction:(UIButton *)sender {
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate = self;
    
    [self presentViewController:pickerVC animated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [self startScanQRCodeFromImage:image];
    }];
}

- (void)startScanQRCodeFromImage:(UIImage *)img{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    CIImage *sourceImage = [CIImage imageWithCGImage:img.CGImage];
    NSArray *res = [detector featuresInImage:sourceImage];
    
    if (res.count > 0) {
        CIQRCodeFeature *item = [res lastObject];
        UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:@"result" message:item.messageString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alerVc addAction:action];
        [self presentViewController:alerVc animated:YES completion:nil];
        
    }else{
        UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:@"result" message:@"can not scan" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alerVc addAction:action];
        [self presentViewController:alerVc animated:YES completion:nil];
    }
    
}
@end
