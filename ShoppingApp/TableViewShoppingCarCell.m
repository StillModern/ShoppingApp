//
//  TableViewShoppingCarCell.m
//  ShoppingApp
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "TableViewShoppingCarCell.h"

@implementation TableViewShoppingCarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imageViewGood = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 100, 100)];
        [self.contentView addSubview:_imageViewGood];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 155, 60)];
        [_labelName setTextColor:[UIColor blueColor]];
        [_labelName setTextAlignment:NSTextAlignmentCenter];
        [_labelName setFont:[UIFont boldSystemFontOfSize:15]];
        [_labelName setNumberOfLines:0];
        [_labelName setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelName];
        
        _buttonCount = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCount setFrame:CGRectMake(120, 75, 40, 25)];
        [_buttonCount setBackgroundColor:[UIColor whiteColor]];
        [_buttonCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonCount.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [_buttonCount addTarget:self action:@selector(buttonCountClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_buttonCount];
        
        _labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(175, 75, 100, 25)];
        [_labelPrice setTextColor:[UIColor blueColor]];
        [_labelPrice setTextAlignment:NSTextAlignmentCenter];
        [_labelPrice setFont:[UIFont boldSystemFontOfSize:20]];
        [_labelPrice setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelPrice];        
        
        UILabel *lLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 105, 50, 25)];
        [lLabel setText:@"总价:"];
        [lLabel setTextColor:[UIColor redColor]];
        [lLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [lLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:lLabel];
        [lLabel release];
        
        _labelAmount = [[UILabel alloc]initWithFrame:CGRectMake(175, 105, 100, 25)];
        [_labelAmount setTextColor:[UIColor redColor]];
        [_labelAmount setFont:[UIFont boldSystemFontOfSize:20]];
        [_labelAmount setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelAmount];
        
        _buttonCheck = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonCheck setFrame:CGRectMake(285, 58, 25, 25)];
        [_buttonCheck setBackgroundImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
        [_buttonCheck addTarget:self action:@selector(buttonCheckClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_buttonCheck];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [_imageViewGood release];
    [_labelName release];
    [_labelPrice release];
    [_labelAmount release];
    [super dealloc];
}

- (void)buttonCountClick:(UIButton *)sender{
    [_delegate buttonCountClick];
}

- (void)buttonCheckClick:(UIButton *)sender{
    [_delegate buttonCheckClick:self];
}

@end
