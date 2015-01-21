//
//  ViewController.m
//  quickExtension
//
//  Created by wantry on 14-9-25.
//  Copyright (c) 2014年 wantry. All rights reserved.
//

#import "ViewController.h"
#import "CallSingleEditViewController.h"

#import "quickKit.h"
#import <AddressBookUI/AddressBookUI.h>
@import NotificationCenter;
@import quickKit;

#define KStartY 80

@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate,UIActionSheetDelegate,CallSingleEditDelegate>
{
    NSMutableArray *arr_callItems;
    
    UIButton *btn_new;
    
    UIView *v_callItemViews;
    
    NSMutableArray *arr_callItemViews;
    
    
    UIView *v_paning;
    
    NSInteger tempIndex;
    
}
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (v_callItemViews) {
        [v_callItemViews removeAllSubview];
    }
    if (arr_callItemViews) {
        [arr_callItemViews removeAllObjects];
    }else
    {
        arr_callItemViews=[NSMutableArray array];
    }
    
    
    if (arr_callItems.count>0)
    {
        for (int i=0; i<arr_callItems.count; i++)
        {
            NSDictionary *dic=arr_callItems[i];
            UIButton *btn=[self createButtonFor:dic];
            [btn setTag:i];
            [v_callItemViews addSubview:btn];
            [arr_callItemViews addObject:btn];
            

//          移动到相应地位置上
            CGPoint p=btn.center;
            p.x=[self centerX:arr_callItems.count Index:i];
            btn.center=p;
            
        }
    }
    
    if (arr_callItems.count<4)
    {
        if (btn_new==nil)
        {
            btn_new=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_new addTarget:self action:@selector(toNewCallSetting:) forControlEvents:UIControlEventTouchUpInside];
            [btn_new setFrame:CGRectMake(0, 0, 75, 75)];
            [btn_new setCenter:CGPointMake(self.view.center.x, kUIScreen_Height*0.85)];
            [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
            [self.view addSubview:btn_new];
            [btn_new.layer addAnimation:[CommonHelper scaleForever_Animation:0.5 ToValue:1.2f] forKey:@"scale"];

        }else{
            [btn_new.layer removeAnimationForKey:@"scale"];
             [btn_new.layer addAnimation:[CommonHelper scaleForever_Animation:0.5 ToValue:1.2f] forKey:@"scale"];
        
        }
       
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:GroupIdentifier];
    NSArray *arr = [shared valueForKey:@"Call"];
    arr_callItems=[NSMutableArray arrayWithArray:arr];
//    if (arr_callItems.count==4) {
//        [arr_callItems removeLastObject];
//        [arr_callItems removeLastObject];
//        [arr_callItems removeLastObject];
//    }
    v_callItemViews=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kUIScreen_Width, kUIScreen_Height*0.5)];
    [v_callItemViews setBackgroundColor:[UIColor clearColor]];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];

    [v_callItemViews addGestureRecognizer:pan];
//    [v_callItemViews.layer setBorderWidth:1.0];
    [self.view addSubview:v_callItemViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toCallSetting:(id)sender
{
    UIButton *button=(UIButton *)sender;

    NSMutableDictionary *mutableDic;

    if (arr_callItems.count>button.tag) {
        NSDictionary *dic=arr_callItems[button.tag];
        if (dic) {
            mutableDic=[NSMutableDictionary dictionaryWithDictionary:dic];
        }
    }
   
    CallSingleEditViewController *call=[[CallSingleEditViewController alloc]init];
    call.dic_contact=mutableDic;
    call.delegate=self;
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:call];
    [self presentViewController:navi animated:YES completion:nil];
}
-(IBAction)toNewCallSetting:(id)sender
{
    CallSingleEditViewController *call=[[CallSingleEditViewController alloc]init];
    call.delegate=self;
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:call];
    [self presentViewController:navi animated:YES completion:nil];

}







- (NSString *)readDataFromNSUserDefaults
{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:GroupIdentifier];
    NSString *value = [shared valueForKey:@"Call"];
    
    return value;
}

#pragma mark CallSingleEdit Delegate
-(void)CallSingleEdit:(CallSingleEditViewController *)vc DidCancel:(NSMutableDictionary *)originContact
{
    [vc dismissViewControllerAnimated:YES completion:nil];
}
- (void)CallSingleEdit:(CallSingleEditViewController *)vc DidSave:(NSMutableDictionary *)contact
{
    if (vc.dic_contact)
    {
        [arr_callItems replaceObjectAtIndex:[arr_callItems indexOfObject:vc.dic_contact] withObject:contact];
    }else
    {
    
        [arr_callItems addObject:contact];
    }
    [CommonHelper saveTextByNSUserDefaults:arr_callItems];
    [self showAddHideButton];
    [vc dismissViewControllerAnimated:YES completion:nil];
    [[NCWidgetController widgetController]setHasContent:YES forWidgetWithBundleIdentifier:nil];

}

#pragma mark Custom Button
-(UIButton *)createButtonFor:(NSDictionary *)dic
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(toCallSetting:) forControlEvents:UIControlEventTouchUpInside];
    if(dic[KeyItemImagePath])
    {
        NSString *path=[CommonHelper pathForImageId:dic[KeyItemImagePath]].relativePath;
        UIImage *image=[UIImage imageWithContentsOfFile:path];
        [btn setImage:image forState:UIControlStateNormal];
    }
    [btn setFrame:CGRectMake(0,KStartY,kUIScreen_Width/4,kUIScreen_Width/4)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:btn];
    [btn.imageView.layer setCornerRadius:(kUIScreen_Width/4-6)/2];
    [btn.imageView setClipsToBounds:YES];
    [btn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(3,3,3,3)];
    
    return btn;
}

-(CGFloat)centerX:(NSInteger)total Index:(NSInteger)i
{
   CGFloat with=    kUIScreen_Width/(total*2);
    CGFloat x=with*(2*i+1);
    
    return x;
}
#pragma mark ShowAddButton
-(void)showAddHideButton
{
    if (arr_callItems.count<4)
    {
        if (btn_new==nil)
        {
            btn_new=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_new addTarget:self action:@selector(toNewCallSetting:) forControlEvents:UIControlEventTouchUpInside];
            [btn_new setFrame:CGRectMake(0, 0, 75, 75)];
            [btn_new setCenter:CGPointMake(self.view.center.x, kUIScreen_Height*0.85)];
            [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
            [self.view addSubview:btn_new];
            
        }else{
            [btn_new.layer removeAnimationForKey:@"scale"];
            [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
            
        }
        
    }else if(arr_callItems.count>=4)
    {
        [btn_new removeFromSuperview];
        btn_new=nil;
    }



}

#pragma mark 手势处理
-(IBAction)pan:(UIPanGestureRecognizer *)panGesture
{
    CGPoint touchPoint=[panGesture locationInView:v_callItemViews];
    CGPoint centerPoint=[panGesture locationInView:self.view];

    if (panGesture.state==UIGestureRecognizerStateBegan)
    {
        for (UIView *subView in arr_callItemViews)
        {
            if (CGRectContainsPoint(subView.frame, touchPoint))
            {
                v_paning=subView;
                tempIndex=[arr_callItemViews indexOfObject:subView];
                break;
            }
        }
        
    }else if (panGesture.state==UIGestureRecognizerStateChanged)
    {
        v_paning.center=centerPoint;
        
        if (btn_new==nil)
        {
            btn_new=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_new addTarget:self action:@selector(toNewCallSetting:) forControlEvents:UIControlEventTouchUpInside];
            [btn_new setFrame:CGRectMake(0, 0, 75, 75)];
            [btn_new setCenter:CGPointMake(self.view.center.x, kUIScreen_Height*0.85)];
            [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
            [self.view addSubview:btn_new];
            [btn_new.layer addAnimation:[CommonHelper scaleForever_Animation:0.5 ToValue:1.2f] forKey:@"scale"];
        }else
        {
            [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];

        }
        
        
        
        //将父视图中的点转换到子视图上
        CGPoint point2=[self.view convertPoint:touchPoint toView:v_callItemViews];
        if (point2.x<0) point2.x=0;
        
        if (point2.y>CGRectGetHeight(v_callItemViews.frame)) {
            // 删除联系人操作
//            return ;
            if (CGRectContainsPoint(btn_new.frame, centerPoint))
            {
                [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_delete_on"] forState:UIControlStateNormal];
            }else
            {
                return ;
            }
        }

    }else if (panGesture.state==UIGestureRecognizerStateCancelled || panGesture.state==UIGestureRecognizerStateEnded ||panGesture.state==UIGestureRecognizerStateFailed)
    {
        if (CGRectContainsPoint(btn_new.frame, centerPoint))
        {
            [btn_new setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
            [v_paning removeFromSuperview];
            [arr_callItems removeObjectAtIndex:v_paning.tag];
            [arr_callItemViews removeObjectAtIndex:v_paning.tag];
            [CommonHelper saveTextByNSUserDefaults:arr_callItems];
            
            for (int i=0; i<arr_callItemViews.count; i++) {
                UIButton *btn=[arr_callItemViews objectAtIndex:i];
                btn.tag=i;
                
                CGPoint p=btn.center;
                p.x=[self centerX:arr_callItemViews.count Index:i];
                btn.center=p;
                
                
            }
            
        }else
        {
          CGFloat x=  [self centerX:arr_callItems.count Index:v_paning.tag];
            CGRect rect=v_paning.frame;
            rect.origin.y=KStartY;
            v_paning.frame=rect;
            [UIView animateWithDuration:0.2 animations:^{
                v_paning.center=CGPointMake(x, KStartY+CGRectGetHeight(v_paning.frame)/2);
                
            }];
            
            

        }
        [self showAddHideButton];
        
        
    }

}


@end
