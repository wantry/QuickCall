//
//  TypeSettingViewController.m
//  quickExtension
//
//  Created by wantry on 15/1/6.
//  Copyright (c) 2015年 wantry. All rights reserved.
//


#import "TypeSettingViewController.h"

@import quickKit;
@interface TypeSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr_types;

}
@end

@implementation TypeSettingViewController
@synthesize completeBlock,originType;

-(id)initWithCompleteBlock:(TypeSettingComplete)block WithType:(NSString *)type
{
    self=[super init];
    if (self) {
        self.completeBlock=block;
        self.originType=type;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"选择类型"];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *path=[[paths objectAtIndex:0] stringByAppendingPathComponent:KeyItemPlistFileName];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    if (!arr || ![arr isKindOfClass:[NSArray class]]) {
        NSDictionary *dic1=@{KeyItemName:KeyItemNameTel,KeyItemType:KeyItemTypeTel};
        NSDictionary *dic2=@{KeyItemName:KeyItemNameFaceTimeAudio,KeyItemType:KeyItemTypeFaceTimeAudio};
        NSDictionary *dic3=@{KeyItemName:KeyItemNameFaceTimeVideo,KeyItemType:KeyItemTypeFaceTimeVideo};
        arr=[NSArray arrayWithObjects:dic1,dic2,dic3, nil];
        [arr writeToFile:path atomically:YES];
    }
    if (arr) {
        arr_types=[NSArray arrayWithArray:arr];
    }
    
    UITableView *table=[[UITableView  alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    
    
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
#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_types.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic=[arr_types objectAtIndex:indexPath.row];
    if ([dic[KeyItemType] isEqualToString:self.originType])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    cell.textLabel.text=dic[KeyItemName];
    return  cell;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[arr_types objectAtIndex:indexPath.row];
    if (completeBlock)
    {
        completeBlock(dic);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
