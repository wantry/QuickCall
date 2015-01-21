//
//  UIView-Helper.m
//  xiangle
//
//  Created by Yuan Shuai on 13-8-1.
//  Copyright (c) 2013年 xiangle.me. All rights reserved.
//

#import "UIView-Helper.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView(Helper)
//移除所有子视图
-(void)removeAllSubview
{
    NSUInteger count=self.subviews.count;
    for (int i=0;i<count;i++) {
        [[self.subviews objectAtIndex:0] removeFromSuperview];
    }
}

//将view变成UIImage
-(UIImage*)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


//取出vc
- (UIViewController *)viewController
{
    id responder;
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            responder= (UIViewController *)nextResponder;
        }
    }
    return responder;
}
#pragma mark 设置统一风格
-(void)setStyleColor
{
//    [self setBackgroundColor:RGBCOLOR(240, 240, 240)];
}
@end
