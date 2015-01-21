//
//  TypeSettingViewController.h
//  quickExtension
//
//  Created by wantry on 15/1/6.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TypeSettingComplete)(NSDictionary *type);

@interface TypeSettingViewController : UIViewController
@property(nonatomic,strong)TypeSettingComplete completeBlock;
@property(nonatomic)NSString *originType;

-(id)initWithCompleteBlock:(TypeSettingComplete)block WithType:(NSString *)type;

@end
