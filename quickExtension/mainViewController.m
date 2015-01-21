//
//  mainViewController.m
//  quickExtension
//
//  Created by wantry on 15/1/11.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import "CallSingleEditViewController.h"

#import "quickKit.h"
#import <AddressBookUI/AddressBookUI.h>
#import "ContactCollectionViewCell.h"
@import NotificationCenter;
@import quickKit;

#import "mainViewController.h"
#define KStartY 100



@interface mainViewController ()<ABPeoplePickerNavigationControllerDelegate,UIActionSheetDelegate,CallSingleEditDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *arr_callItems;
    
    UIButton *btn_new;
 
    UICollectionView *v_collection;
    
    
}
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:GroupIdentifier];
    NSArray *arr = [shared valueForKey:@"Call"];
    arr_callItems=[NSMutableArray arrayWithArray:arr];
//        if (arr_callItems.count==4) {
//            [arr_callItems removeLastObject];
//            [arr_callItems removeLastObject];
//            [arr_callItems removeLastObject];
//        }
    
    
    FlowLayout *layout=[[FlowLayout alloc]initWithCount:arr_callItems.count];
    v_collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, KStartY, kUIScreen_Width, kUIScreen_Width/4) collectionViewLayout:layout];
    [v_collection registerClass:[ContactCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [v_collection setBackgroundColor:[UIColor clearColor]];
    [v_collection setDelegate:self];
    [v_collection setDataSource:self];
    [self.view addSubview:v_collection];
    
    
    
    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UICollectionView DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return arr_callItems.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *dic=[arr_callItems objectAtIndex:indexPath.row];
    ContactCollectionViewCell *cell=[cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *path=[CommonHelper pathForImageId:dic[KeyItemImagePath]].relativePath;
    UIImage *image=[UIImage imageWithContentsOfFile:path];
    [cell.imageView setImage:image];
    
       return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[arr_callItems objectAtIndex:indexPath.row];
    
    NSMutableDictionary *mutableDic;
    
        if (dic) {
            mutableDic=[NSMutableDictionary dictionaryWithDictionary:dic];
        }

    
    CallSingleEditViewController *call=[[CallSingleEditViewController alloc]init];
    call.dic_contact=mutableDic;
    call.delegate=self;
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:call];
    [self presentViewController:navi animated:YES completion:nil];

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
    [vc dismissViewControllerAnimated:YES completion:nil];
}



-(IBAction)toNewCallSetting:(id)sender
{
    CallSingleEditViewController *call=[[CallSingleEditViewController alloc]init];
    call.delegate=self;
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:call];
    [self presentViewController:navi animated:YES completion:nil];
    
}


@end
