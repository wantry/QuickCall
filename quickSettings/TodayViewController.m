//
//  TodayViewController.m
//  quickSettings
//
//  Created by wantry on 14-9-25.
//  Copyright (c) 2014年 wantry. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"viewDidLoad");

    UIButton *btn_data=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_data addTarget:self action:@selector(btn_quickData:) forControlEvents:UIControlEventTouchUpInside];
    [btn_data setTitle:@"蜂窝" forState:UIControlStateNormal];
    [btn_data setFrame:CGRectMake([self x:0], 10, 60, 60)];
    [self.view addSubview:btn_data];
    
    
    UIButton *btn_location=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_location addTarget:self action:@selector(btn_quickLocation:) forControlEvents:UIControlEventTouchUpInside];
    [btn_location setTitle:@"位置" forState:UIControlStateNormal];
    [btn_location setFrame:CGRectMake([self x:1], 10, 60, 60)];
    [self.view addSubview:btn_location];

    UIButton *btn_notification=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_notification addTarget:self action:@selector(btn_quickNotification:) forControlEvents:UIControlEventTouchUpInside];
    [btn_notification setTitle:@"通知" forState:UIControlStateNormal];
    [btn_notification setFrame:CGRectMake([self x:2], 10, 60, 60)];
    [self.view addSubview:btn_notification];
    
    UIButton *btn_hot=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_hot addTarget:self action:@selector(btn_quickHotPoint:) forControlEvents:UIControlEventTouchUpInside];
    [btn_hot setTitle:@"热点" forState:UIControlStateNormal];
    [btn_hot setFrame:CGRectMake([self x:3], 10, 60, 60)];
    [self.view addSubview:btn_hot];

    
    UIButton *btn_vpn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_vpn addTarget:self action:@selector(btn_quickVPN:) forControlEvents:UIControlEventTouchUpInside];
    [btn_vpn setTitle:@"VPN" forState:UIControlStateNormal];
    [btn_vpn setFrame:CGRectMake([self x:4], 10, 60, 60)];
    [self.view addSubview:btn_vpn];

    
    
    
    CGSize updatedSize = [self preferredContentSize];
    updatedSize.height = 100.0;
    [self setPreferredContentSize:updatedSize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
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


-(IBAction)btn_quickLocation:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    [self.extensionContext openURL:url completionHandler:nil];
}
-(IBAction)btn_quickData:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"];
    [self.extensionContext openURL:url completionHandler:nil];
}
-(IBAction)btn_quickVPN:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"prefs:root=General&path=Network/VPN"];
    [self.extensionContext openURL:url completionHandler:nil];
    
}
-(IBAction)btn_quickNotification:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
    [self.extensionContext openURL:url completionHandler:nil];
}
-(IBAction)btn_quickHotPoint:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"prefs:root=INTERNET_TETHERING"];
    [self.extensionContext openURL:url completionHandler:nil];
}

-(NSInteger)x:(NSInteger)i
{
    return i*(50+5)+10;

}


@end
