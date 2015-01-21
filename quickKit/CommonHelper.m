//
//  CommonHelper.m
//  quickExtension
//
//  Created by wantry on 15/1/5.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper

+(NSURL *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];

        NSURL *containerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:GroupIdentifier];
        containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/images"];
    
    BOOL isDir;
    BOOL existed=[fileManager fileExistsAtPath:containerURL.absoluteURL.absoluteString isDirectory:&isDir];
    
    
    
    
    if ( !(isDir == YES && existed == YES) )
    {
        NSError *error;
        BOOL result=[fileManager createDirectoryAtURL:containerURL withIntermediateDirectories:YES attributes:nil error:&error];
        if (!result) {
            NSLog(@"%@",[error description]);
        }
    }
    
    
    
    return containerURL;
}
+(NSURL *)pathForImageId:(NSString *)imageId
{
    NSURL *containerURL = [CommonHelper path];
    containerURL = [containerURL URLByAppendingPathComponent:imageId];
    return containerURL;
}




+(CABasicAnimation *)scaleForever_Animation:(float)time ToValue:(CGFloat)ToValue

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:ToValue];
    
    animation.duration=time;
    
    // 在from 和 to 之间循环 reverse 倒退
    animation.autoreverses=YES;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
}
/*放大动画 参数 动画显示次数 动画时长 放大值*/
+(CABasicAnimation *)scaleAnimationRepeatCount:(float)count Duration:(float)time ToValue:(float)ToValue
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:ToValue];
    
    animation.duration=time;
    
    // 在from 和 to 之间循环 reverse 倒退
    animation.autoreverses=YES;
    
    animation.repeatCount=count;
    
    animation.removedOnCompletion=YES;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;

}

+ (void)saveTextByNSUserDefaults:(id)object
{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:GroupIdentifier];
    [shared setObject:object forKey:@"Call"];
    [shared synchronize];
}



@end
