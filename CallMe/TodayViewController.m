//
//  TodayViewController.m
//  CallMe
//
//  Created by wantry on 14/12/29.
//  Copyright (c) 2014年 wantry. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
@import quickKit;

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear");
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSLog(@"view did appear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"viewDidload");
    // Do any additional setup after loading the view from its nib.
//    [self.view removeAllSubview];
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:GroupIdentifier];
    NSArray *value = [shared valueForKey:@"Call"];
    for (int i=0; i<value.count; i++) {
        NSDictionary *dic=value[i];
        UIButton *btn=[self createButton:dic AtIndex:i];
        [btn setFrame:CGRectMake(i*(60*SCREEN_RATIO_Wide+10)+47,5,60*SCREEN_RATIO_Wide,60*SCREEN_RATIO_Wide)];
        NSString *path=[CommonHelper pathForImageId:dic[KeyItemImagePath]].relativePath;
        UIImage *image=[UIImage imageWithContentsOfFile:path];
        [btn setImage:image forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.view addSubview:btn];
        [btn.imageView.layer setCornerRadius:10];
    }

    
    CGSize updatedSize = [self preferredContentSize];
    updatedSize.height = 60.0*SCREEN_RATIO_Wide+10;
    [self setPreferredContentSize:updatedSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(UIButton *)createButton:(NSDictionary *)dic
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:dic[@"title"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(UIButton *)createButton:(NSDictionary *)dic AtIndex:(NSInteger)index
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTag:index];
    [btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(IBAction)call:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    [btn setAlpha:0.5];
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:GroupIdentifier];
    NSArray *value = [shared valueForKey:@"Call"];
    NSDictionary *dic=value[btn.tag];
    NSString *str=[NSString stringWithFormat:@"%@%@",dic[KeyItemType],dic[KeyItemUrl]];
    if (str==nil) {
        return ;
    }
    NSURL *url=[NSURL URLWithString:str];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        if (success) {
            [btn setAlpha:1.0];
        }
    }];


}

@end
