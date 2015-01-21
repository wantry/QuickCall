//
//  CallSettingViewController.m
//  quickExtension
//
//  Created by wantry on 15/1/4.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import "CallSingleEditViewController.h"
#import "TypeSettingViewController.h"
#import <AddressBookUI/AddressBookUI.h>

#import "quickKit.h"
@import NotificationCenter;
#define KstartX 25

@interface CallSingleEditViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    UIButton *btn_portrait;
    UIButton *btn_urlType;
    UIButton *btn_contactsList;

    UIButton *btn_save;
    UIButton *btn_cancel;
    
    
    UITextField *tf_url;
    
    
    NSMutableDictionary *dic_EditContact;
}
@end

@implementation CallSingleEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBCOLOR(233, 233, 233)];
    self.title=@"修改";
    // Do any additional setup after loading the view.
    
    if (_dic_contact)
    {
            dic_EditContact=[NSMutableDictionary dictionaryWithDictionary:_dic_contact];
    }
    
    if (dic_EditContact==nil) {
        dic_EditContact=[NSMutableDictionary dictionary];
    }
    
    btn_portrait=[UIButton  buttonWithType:UIButtonTypeCustom];
    if(_dic_contact[KeyItemImagePath])
    {
        NSString *fileName=_dic_contact[KeyItemImagePath];
        NSString *path=[CommonHelper pathForImageId:fileName].relativePath;
        
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:path];
      [btn_portrait setImage:image forState:UIControlStateNormal];
    }else
    {
        UIImage *image=[UIImage imageNamed:@"btn_face"];
        [btn_portrait setBackgroundImage:image forState:UIControlStateNormal];
        [btn_portrait.layer addAnimation:[CommonHelper scaleForever_Animation:0.5f ToValue:1.05f] forKey:@"scale"];
    }
    
    [btn_portrait addTarget:self action:@selector(ToPickerImage:) forControlEvents:UIControlEventTouchUpInside];
    [btn_portrait setFrame:CGRectMake(kUIScreen_Width*0.2,80,kUIScreen_Width*0.6,kUIScreen_Width*0.6)];
    [btn_portrait.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:btn_portrait];
    [btn_portrait.imageView.layer setCornerRadius:kUIScreen_Width*0.6*0.5];
    
//    UIView *tool=[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(btn_portrait.frame)*0.8,CGRectGetWidth(btn_portrait.frame), CGRectGetHeight(btn_portrait.frame)*0.2)];
//    [tool setBackgroundColor:[UIColor whiteColor]];
//    [btn_portrait addSubview:tool];
    UIView *tool=[[UIView alloc]initWithFrame:CGRectMake(btn_portrait.frame.origin.x,CGRectGetHeight(btn_portrait.frame)+btn_portrait.frame.origin.y,CGRectGetWidth(btn_portrait.frame), CGRectGetHeight(btn_portrait.frame)*0.2)];
    
    [tool setFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.1, CGRectGetHeight(btn_portrait.frame)+btn_portrait.frame.origin.y+10,CGRectGetWidth(self.view.frame)*0.8,40)];
    
    
    [tool setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tool];

    
    btn_urlType=[UIButton  buttonWithType:UIButtonTypeCustom];
    if ([_dic_contact[KeyItemType] isEqualToString:KeyItemTypeTel] || [_dic_contact[KeyItemType] isEqualToString:KeyItemTypeFaceTimeAudio])
    {
        [btn_urlType setImage:[UIImage imageNamed:@"btn_tel"] forState:UIControlStateNormal];

    }
    if ([_dic_contact[KeyItemType] isEqualToString:KeyItemTypeFaceTimeVideo])
    {
        [btn_urlType setImage:[UIImage imageNamed:@"btn_video"] forState:UIControlStateNormal];
    }
    if (_dic_contact[KeyItemType]==nil)
    {
        [btn_urlType setImage:[UIImage imageNamed:@"btn_tel"] forState:UIControlStateNormal];
    }


    if (_dic_contact)
    {
        [self showTypeSelectAndNumberInput];
//        [btn_urlType addTarget:self action:@selector(ToType:) forControlEvents:UIControlEventTouchUpInside];
//        [btn_urlType setFrame:CGRectMake(0,0,CGRectGetHeight(tool.frame),CGRectGetHeight(tool.frame))];
//        [btn_urlType setBackgroundColor:[UIColor whiteColor]];
//        [btn_urlType.layer setCornerRadius:CGRectGetHeight(tool.frame)*0.5];
//        [tool addSubview:btn_urlType];
//        
//        tf_url=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth(btn_urlType.frame)+10,0, CGRectGetWidth(tool.frame)-CGRectGetWidth(btn_urlType.frame)-40, CGRectGetHeight(tool.frame))];
//        tf_url.delegate=self;
//        [tf_url setBackgroundColor:[UIColor whiteColor]];
//        [tf_url  setTextColor:RGBCOLOR(255, 130, 0)];
//        [tool addSubview:tf_url];
//        [tf_url setPlaceholder:@"电话号码"];
//        tf_url.borderStyle=UITextBorderStyleRoundedRect;
//        
//        if (_dic_contact[KeyItemUrl])
//            tf_url.text=_dic_contact[KeyItemUrl];
//        
//        
//        
//        btn_contactsList=[UIButton  buttonWithType:UIButtonTypeCustom];
//        [btn_contactsList addTarget:self action:@selector(ToPeoplelist:) forControlEvents:UIControlEventTouchUpInside];
//        [btn_contactsList setFrame:CGRectMake(CGRectGetWidth(tf_url.frame)-CGRectGetHeight(tool.frame)*0.8,CGRectGetHeight(tool.frame)*0.1, CGRectGetHeight(tool.frame)*0.8,CGRectGetHeight(tool.frame)*0.8)];
//        [btn_contactsList setImage:[UIImage imageNamed:@"btn_contact"] forState:UIControlStateNormal];
//        [tf_url addSubview:btn_contactsList];
    }else
    {
        self.title=NSLocalizedString(@"image", @"");
    }
    
    

    
    
    
    
    
    btn_save=[UIButton  buttonWithType:UIButtonTypeCustom];
    [btn_save setBackgroundImage:[UIImage imageNamed:@"btn_yes"] forState:UIControlStateNormal];
    [btn_save addTarget:self action:@selector(ToSave:) forControlEvents:UIControlEventTouchUpInside];
    [btn_save setFrame:CGRectMake(KstartX,kUIScreen_Height*0.75, 60*SCREEN_RATIO_Wide,60*SCREEN_RATIO_Wide)];
    CGPoint p=btn_save.center;
    p.x=kUIScreen_Width/5*3;
    btn_save.center=p;
    [self.view addSubview:btn_save];
    
    
    
    btn_cancel=[UIButton  buttonWithType:UIButtonTypeCustom];
    [btn_cancel setBackgroundImage:[UIImage imageNamed:@"btn_no"] forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(ToCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btn_cancel setFrame:CGRectMake(KstartX,kUIScreen_Height*0.75,60*SCREEN_RATIO_Wide,60*SCREEN_RATIO_Wide)];
    CGPoint p2=btn_cancel.center;
    p2.x=kUIScreen_Width/5*2;
    btn_cancel.center=p2;
    [self.view addSubview:btn_cancel];


    
    

    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [tf_url resignFirstResponder];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark 显示编辑框和类型选择
-(void)showTypeSelectAndNumberInput
{
    [btn_urlType addTarget:self action:@selector(ToType:) forControlEvents:UIControlEventTouchUpInside];
    [btn_urlType setFrame:CGRectMake(0,0,40*SCREEN_RATIO_Wide,40*SCREEN_RATIO_Wide)];
    [btn_urlType setBackgroundColor:[UIColor clearColor]];
//    [btn_urlType.layer setBorderWidth:1.0];
    CALayer *layer=[CALayer layer];
    [layer setFrame:CGRectMake(CGRectGetWidth(btn_urlType.frame), 8, 0.5f, CGRectGetHeight(btn_urlType.frame)-16)];
    [layer setBackgroundColor:kColorLine.CGColor];
    [btn_urlType.layer addSublayer:layer];
    
    
    
    tf_url=[[UITextField alloc]initWithFrame:CGRectMake(0,btn_portrait.frame.origin.y+btn_portrait.frame.size.height+10,180*SCREEN_RATIO_Wide,40*SCREEN_RATIO_Wide)];
    tf_url.delegate=self;
    [tf_url setBackgroundColor:[UIColor whiteColor]];
    [tf_url  setTextColor:RGBCOLOR(255, 130, 0)];
    [self.view addSubview:tf_url];
    tf_url.borderStyle=UITextBorderStyleRoundedRect;
    tf_url.leftView=btn_urlType;
    tf_url.leftViewMode=UITextFieldViewModeAlways;
    tf_url.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
//    [tf_url.layer setBorderWidth:1.0];
    
    CGPoint p=tf_url.center;
    p.x=self.view.center.x;
    tf_url.center=p;
    
    if (_dic_contact[KeyItemUrl])
        tf_url.text=_dic_contact[KeyItemUrl];
    
    
    
    btn_contactsList=[UIButton  buttonWithType:UIButtonTypeCustom];
    [btn_contactsList addTarget:self action:@selector(ToPeoplelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn_contactsList setFrame:CGRectMake(CGRectGetWidth(tf_url.frame)+tf_url.frame.origin.x-2, tf_url.frame.origin.y, 40*SCREEN_RATIO_Wide, 40*SCREEN_RATIO_Wide)];
    [btn_contactsList setImage:[UIImage imageNamed:@"btn_contact"] forState:UIControlStateNormal];
    [btn_contactsList setHidden:YES];
//    [btn_contactsList.layer setBorderWidth:1.0];
    [self.view addSubview:btn_contactsList];
//    [btn_contactsList setBackgroundColor:[UIColor whiteColor]];
    
}


#pragma mark IBAction
-(IBAction)ToPickerImage:(id)sender
{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing=YES;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(IBAction)ToType:(id)sender
{
//     dic_EditContact[KeyItemType]=@"tel://";
    
    NSString *originType=_dic_contact[KeyItemType];
    if (!originType) {
        originType=KeyItemTypeTel;
    }
    if (dic_EditContact[KeyItemType]) {
        originType=dic_EditContact[KeyItemType];
    }
    
    TypeSettingViewController *type=[[TypeSettingViewController alloc]initWithCompleteBlock:^(NSDictionary *type) {
        dic_EditContact[KeyItemType]=type[KeyItemType];
        dic_EditContact[KeyItemName]=type[KeyItemName];
        
        
        
        if ([type[KeyItemType] isEqualToString:KeyItemTypeTel] || [type[KeyItemType] isEqualToString:KeyItemTypeFaceTimeAudio])
        {
            [btn_urlType setImage:[UIImage imageNamed:@"btn_tel"] forState:UIControlStateNormal];
        }
        else if ([type[KeyItemType] isEqualToString:KeyItemTypeFaceTimeVideo])
        {
            [btn_urlType setImage:[UIImage imageNamed:@"btn_video"] forState:UIControlStateNormal];
        }
        else
        {
            [btn_urlType setTitle:type[KeyItemName] forState:UIControlStateNormal];
        }
        
        
        
        
        
        

    } WithType:originType];
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:type];
    [self presentViewController:navi animated:YES completion:nil];

    

}
-(IBAction)ToSave:(id)sender
{
    if ( dic_EditContact[KeyItemImagePath]==nil) {
        return ;
    }
    dic_EditContact[KeyItemUrl]=tf_url.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(CallSingleEdit:DidSave:)]) {
        [self.delegate CallSingleEdit:self DidSave:dic_EditContact];
    }


}
-(IBAction)ToCancel:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CallSingleEdit:DidCancel:)]) {
        [self.delegate CallSingleEdit:self DidCancel:_dic_contact];
    }


}
-(IBAction)ToPeoplelist:(id)sender
{
    ABPeoplePickerNavigationController *e=[[ABPeoplePickerNavigationController alloc]init];
    e.peoplePickerDelegate=self;
//    e.displayedProperties=@[@(kABPersonPhoneProperty)];
    e.displayedProperties=@[@(kABPersonPhoneProperty),@(kABPersonEmailProperty)];
    [self presentViewController:e animated:YES completion:nil];



}

#pragma mark UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
   __block BOOL writeSuccess;
    
    UIImage *editImage=info[@"UIImagePickerControllerEditedImage"];
    NSURL *imageUrl=info[@"UIImagePickerControllerReferenceURL"];
    if (imageUrl)
    {
        NSString *s=   [[[imageUrl absoluteString] MD5String] stringByAppendingString:@".jpg"];
        NSURL *url=[CommonHelper pathForImageId:s];
        
        dispatch_async(dispatch_queue_create(nil, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            NSError *error;
            BOOL result=[UIImageJPEGRepresentation(editImage,KImageLevel) writeToURL:url options:NSDataWritingAtomic error:&error];
            if (!result) {
                NSLog(@"%@",[error debugDescription]);
            }else
            {
                writeSuccess=YES;
                dic_EditContact[KeyItemImagePath]=s;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn_portrait setImage:editImage forState:UIControlStateNormal];
                    [btn_portrait.layer removeAnimationForKey:@"scale"];
                 
                });
                
            }
            
        });
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (writeSuccess)
        {
            if(_dic_contact==nil)
            {
                [self showTypeSelectAndNumberInput];
            }
            self.title=NSLocalizedString(@"number", @"");
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark ABPeoplePickerNavigationController Delegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, property);
    
    NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, identifier);
    
    BOOL IsNumber;
    if (property==kABPersonPhoneProperty)
    {
        IsNumber=YES;
    }else if (property==kABPersonEmailProperty)
    {
        IsNumber=NO;
    }
    
    dic_EditContact[KeyItemUrl]=personPhone;
    tf_url.text=personPhone;
    
    
    [[NCWidgetController widgetController]setHasContent:YES forWidgetWithBundleIdentifier:nil];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    
}

#pragma mark UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [btn_contactsList setHidden:NO];
//    [btn_contactsList.layer addAnimation:[CommonHelper scaleAnimationRepeatCount:3.0 Duration:0.5 ToValue:0.8] forKey:@"scale"];
    
    if (CGRectGetHeight(self.view.frame)<=480.0f) {
        CGRect rect=self.view.frame;
        rect.origin.y=rect.origin.y-100;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=rect;
        }];
    }
    

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [btn_contactsList setHidden:YES];
    
    if (CGRectGetHeight(self.view.frame)<=480.0f) {
        CGRect rect=self.view.frame;
        rect.origin.y=0;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=rect;
        }];
    }
    
    
    
    
}

@end
