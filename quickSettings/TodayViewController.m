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

//    UIButton *btn_data=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_data addTarget:self action:@selector(btn_quickData:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_data setImage:[UIImage imageNamed:@"cellular"] forState:UIControlStateNormal];
//    [btn_data setFrame:CGRectMake([self x:0], 0, 60, 60)];
    
    [self.view addSubview:[self buttonImageName:@"cellular" action:@selector(btn_quickData:) index:0]];
    
    
//    UIButton *btn_location=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_location addTarget:self action:@selector(btn_quickLocation:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_location setImage:[UIImage imageNamed:@"Location"] forState:UIControlStateNormal];
//    [btn_location setFrame:CGRectMake([self x:1], 0, 60, 60)];
//    [self.view addSubview:btn_location];
      [self.view addSubview:[self buttonImageName:@"Location" action:@selector(btn_quickLocation:) index:1]];
    
    
    

//    UIButton *btn_notification=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_notification addTarget:self action:@selector(btn_quickNotification:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_notification setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
//    [btn_notification setFrame:CGRectMake([self x:2], 0, 60, 60)];
//    [self.view addSubview:btn_notification];
          [self.view addSubview:[self buttonImageName:@"notification" action:@selector(btn_quickNotification:) index:2]];
    
    
    
    
//    UIButton *btn_hot=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_hot addTarget:self action:@selector(btn_quickHotPoint:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_hot setImage:[UIImage imageNamed:@"hotpoint"] forState:UIControlStateNormal];
//    [btn_hot setFrame:CGRectMake([self x:3], 0, 60, 60)];
//    [self.view addSubview:btn_hot];
    
          [self.view addSubview:[self buttonImageName:@"hotpoint" action:@selector(btn_quickHotPoint:) index:3]];

    
//    UIButton *btn_vpn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_vpn addTarget:self action:@selector(btn_quickVPN:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_vpn setImage:[UIImage imageNamed:@"vpn"] forState:UIControlStateNormal];
//    [btn_vpn setFrame:CGRectMake([self x:4], 0, 60, 60)];
//    [self.view addSubview:btn_vpn];
    
//           [self.view addSubview:[self buttonImageName:@"vpn" action:@selector(btn_quickVPN:) index:4]];
    

//    UIButton *btn_privacy=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_privacy addTarget:self action:@selector(btn_quickPrivacy:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_privacy setImage:[UIImage imageNamed:@"privacy"] forState:UIControlStateNormal];
//    [btn_privacy setFrame:CGRectMake([self x:5], 0, 60, 60)];
//    [self.view addSubview:btn_privacy];
    
    [self.view addSubview:[self buttonImageName:@"privacy" action:@selector(btn_quickPrivacy:) index:4]];
    
    
    CGSize updatedSize = [self preferredContentSize];
    updatedSize.height = 80.0;
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
    NSURL *url=[NSURL URLWithString:@"prefs:root=VPN"];
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
-(IBAction)btn_quickPrivacy:(id)sender
{
    NSURL *url=[NSURL URLWithString:@"prefs:root=Privacy"];
    [self.extensionContext openURL:url completionHandler:nil];
}
-(NSInteger)x:(NSInteger)i
{
    return i*(50+5)+5;

}


-(UIButton *)buttonImageName:(NSString *)imageName action:(SEL)action index:(NSInteger)index
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button setFrame:CGRectMake(index*55, 0, 50, 50)];
    
    return button;

}

@end
