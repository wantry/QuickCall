//
//  CallSingleEditViewController.h
//  quickExtension
//
//  Created by wantry on 15/1/4.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CallSingleEditDelegate;
@interface CallSingleEditViewController : UIViewController
@property(nonatomic)NSMutableDictionary *dic_contact;
@property(nonatomic)id<CallSingleEditDelegate> delegate;
@end

@protocol CallSingleEditDelegate <NSObject>

-(void)CallSingleEdit:(CallSingleEditViewController *)vc DidSave:(NSMutableDictionary *)contact;
-(void)CallSingleEdit:(CallSingleEditViewController *)vc DidCancel:(NSMutableDictionary *)originContact;
@end