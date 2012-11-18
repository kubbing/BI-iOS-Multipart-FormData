//
//  ToastService.m
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import "ToastService.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation ToastService
{
    CGFloat _kToastSize;
    CGFloat _kToastDuration;
}

+ (ToastService *)sharedService
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init
{
    self = [super init];
    if (self) {
        _kToastSize = 160;
        _kToastDuration = 6 * 0.33;
    }
    
    return self;
}

- (void)toastErrorWithTitle:(NSString *)aTitle subtitle:(NSString *)aSubtitle
{
    if (!aTitle) {
        aTitle = NSLocalizedString(@"Error", nil);
    }
    
    UIView *view = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.minSize = CGSizeMake(_kToastSize, _kToastSize);
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aTitle;
    hud.detailsLabelText = aSubtitle;
    [hud hide:YES afterDelay:_kToastDuration];
}

- (void)toastErrorWithHTTPStatusCode:(NSInteger)statusCode
{
    [self toastErrorWithTitle:nil subtitle:[NSString stringWithFormat:@"HTTP %d", statusCode]];
}

- (MBProgressHUD *)toastActitivyWithTitle:(NSString *)aTitle inView:(UIView *)aView
{
    if (!aTitle) {
        aTitle = NSLocalizedString(@"Please Wait…", nil);
    }
    
    if (!aView) {
        aView = [UIApplication sharedApplication].delegate.window;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.minSize = CGSizeMake(_kToastSize, _kToastSize);
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = aTitle;
    return hud;
}

- (MBProgressHUD *)toastTitle:(NSString *)aTitle subtitle:(NSString *)aSubtitle image:(UIImage *)anImage inView:(UIView *)aView autohide:(BOOL)autohide
{    
    if (!aView) {
        aView = [UIApplication sharedApplication].delegate.window;    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.minSize = CGSizeMake(_kToastSize, _kToastSize);
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = aTitle;
    hud.detailsLabelText = aSubtitle;
    
    if (anImage) {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:anImage];
    }
    else {
        hud.mode = MBProgressHUDModeText;
    }
    
    if (autohide) {
        [hud hide:YES afterDelay:_kToastDuration];
    }
    
    return hud;
}

@end
