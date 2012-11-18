//
//  ToastService.h
//  Table
//
//  Created by Jakub Hladík on 24.10.12.
//  Copyright (c) 2012 Jakub Hladík. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;

@interface ToastService : NSObject

+ (ToastService *)sharedService;

- (void)toastErrorWithTitle:(NSString *)aTitle subtitle:(NSString *)aSubtitle;
- (void)toastErrorWithHTTPStatusCode:(NSInteger)aCode;

- (MBProgressHUD *)toastTitle:(NSString *)aTitle subtitle:(NSString *)aSubtitle image:(UIImage *)anImage inView:(UIView *)aView autohide:(BOOL)autohide;
- (MBProgressHUD *)toastActitivyWithTitle:(NSString *)aTitle inView:(UIView *)aView;

@end
