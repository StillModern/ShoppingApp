//
//  TableViewReViewCell.m
//  ShoppingApp
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "TableViewReViewCell.h"

@implementation TableViewReViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _arrayStar = [[NSMutableArray alloc]init];
        for (int i=0; i<5; i++) {
            UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+30*i, 5, 25, 25)];
            [_arrayStar addObject:lImageView];
            [self.contentView addSubview:lImageView];
        }
        
        _labelDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 300, 55)];
        [_labelDetail setTextColor:[UIColor blueColor]];
        [_labelDetail setFont:[UIFont boldSystemFontOfSize:15]];
        [_labelDetail setNumberOfLines:0];
        [_labelDetail setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelDetail];
        
        _labelDate = [[UILabel alloc]initWithFrame:CGRectMake(10, 95, 120, 20)];
        [_labelDate setTextColor:[UIColor redColor]];
        [_labelDate setFont:[UIFont boldSystemFontOfSize:12]];
        [_labelDate setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelDate];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(160, 95, 150, 20)];
        [_labelName setTextColor:[UIColor blueColor]];
        [_labelName setFont:[UIFont boldSystemFontOfSize:15]];
        [_labelName setTextAlignment:NSTextAlignmentRight];
        [_labelName setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_labelName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    [_arrayStar release];
    [_labelDetail release];
    [_labelDate release];
    [_labelName release];
    [super dealloc];
}

@end
