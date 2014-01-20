//
//  CustomCollectionViewCell.m
//  ShoppingApp
//
//  Created by TY on 14-1-9.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgaeView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imgaeView];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
        [_labelName setTextColor:[UIColor blueColor]];
        [_labelName setTextAlignment:NSTextAlignmentCenter];
        [_labelName setFont:[UIFont boldSystemFontOfSize:10]];
        [_labelName setNumberOfLines:3];
        [_labelName setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelName];
        
        _labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, 60, 20)];
        [_labelPrice setTextColor:[UIColor redColor]];
        [_labelPrice setTextAlignment:NSTextAlignmentCenter];
        [_labelPrice setFont:[UIFont boldSystemFontOfSize:12]];
        [_labelPrice setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelPrice];
    }
    return self;
}

- (void)dealloc{
    [_imgaeView release];
    [_labelName release];
    [_labelPrice release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
