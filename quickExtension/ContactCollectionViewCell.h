//
//  ContactCollectionViewCell.h
//  quickExtension
//
//  Created by wantry on 15/1/11.
//  Copyright (c) 2015年 wantry. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ContactCollectionViewCell : UICollectionViewCell
{
    
}
@property(nonatomic)UIImageView *imageView;
@property(nonatomic)UIImageView *selectedView;
@end


@interface FlowLayout : UICollectionViewFlowLayout

-(id)initWithCount:(NSInteger)total;


-(id)initWithCount:(NSInteger)total WithFrame:(CGRect)rect;

-(void)setCount:(NSInteger)total WithFrame:(CGRect)rect;


@end