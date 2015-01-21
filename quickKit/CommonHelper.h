//
//  CommonHelper.h
//  quickExtension
//
//  Created by wantry on 15/1/5.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject

+(NSURL *)path;
+(NSURL *)pathForImageId:(NSString *)imageId;


/* 放大缩小动画*/
+(CABasicAnimation *)scaleForever_Animation:(float)time ToValue:(CGFloat)ToValue;

/*放大动画 参数 动画显示次数 动画时长 放大值*/
+(CABasicAnimation *)scaleAnimationRepeatCount:(float)count Duration:(float)time ToValue:(float)ToValue;


/*将文件存在group中*/
+ (void)saveTextByNSUserDefaults:(id)object;


@end
