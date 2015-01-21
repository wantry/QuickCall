//
//  ContactCollectionViewCell.m
//  quickExtension
//
//  Created by wantry on 15/1/11.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import "ContactCollectionViewCell.h"

@implementation ContactCollectionViewCell
@synthesize imageView,selectedView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.imageView = [[UIImageView alloc] init];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setClipsToBounds:YES];
        [self.contentView addSubview:self.imageView];
        self.selectedView=[[UIImageView alloc]init];
        [self.contentView addSubview:self.selectedView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // _image.frame = self.contentView.bounds;
    self.imageView.frame = CGRectMake(0.0f,0.0f , self.contentView.bounds.size.width, self.contentView.bounds.size.width);
    [self.imageView.layer setCornerRadius:CGRectGetWidth(self.imageView.frame)/2];
    self.selectedView.frame=CGRectMake(50, 5, 20, 20);
    //    self.selectedView.image=[UIImage imageNamed:@"btn_camerapicker_photounselected.png"];
}
@end


@implementation FlowLayout
- (id)init
{
    self=[super init];
    if (self)
    {
//        self.itemSize=CGSizeMake((kUIScreen_Width-12)/4,(kUIScreen_Width-12)/4);
        self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing=1;
        self.minimumLineSpacing=1;
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    }
    return self;
}

-(id)initWithCount:(NSInteger)total
{
    self=[super init];
    if (self) {
//        self.itemSize=CGSizeMake((kUIScreen_Width-12)/total,(kUIScreen_Width-12)/total);
        self.itemSize=CGSizeMake(kUIScreen_Width/total, kUIScreen_Width/total);
    }
    return self;

}


-(id)initWithCount:(NSInteger)total WithFrame:(CGRect)rect
{
    self=[super init];
    if (self)
    {
        self.itemSize=CGSizeMake(CGRectGetWidth(rect)/total,CGRectGetHeight(rect)/total);
//        self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
//        self.minimumInteritemSpacing=0;
//        self.minimumLineSpacing=1;
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    }
    return self;
}

-(void)setCount:(NSInteger)total WithFrame:(CGRect)rect
{
    self.itemSize=CGSizeMake(CGRectGetWidth(rect)/total,CGRectGetHeight(rect)/total);
}


@end


