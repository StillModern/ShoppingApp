//
//  QuerryOrderOtherViewCell.m
//  ShoppingApp
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "QuerryOrderOtherViewCell.h"

@implementation QuerryOrderOtherViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
    
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 45, 20)]autorelease];
    UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(165, 0, 50, 20)]autorelease];
    UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(15, 23, 30, 20)]autorelease];
    UILabel *label4 = [[[UILabel alloc]initWithFrame:CGRectMake(130, 23, 50, 20)]autorelease];
    UILabel *label5 = [[[UILabel alloc]initWithFrame:CGRectMake(15, 46, 30, 20)]autorelease];
    UILabel *label6 = [[[UILabel alloc]initWithFrame:CGRectMake(130, 46, 30, 20)]autorelease];
    UILabel *label7 = [[[UILabel alloc]initWithFrame:CGRectMake(15, 69, 30, 20)]autorelease];
    UILabel *label8 = [[[UILabel alloc]initWithFrame:CGRectMake(100, 69, 30, 20)]autorelease];
    label1.text = @"订单号：";
    label2.text = @"交易情况：";
    label3.text = @"价格：";
    label4.text = @"交易日期：";
    label5.text = @"姓名：";
    label6.text = @"电话：";
    label7.text = @"邮编：";
    label8.text = @"地址：";
    label1.font = [UIFont systemFontOfSize:10];
    label2.font = [UIFont systemFontOfSize:10];
    label3.font = [UIFont systemFontOfSize:10];
    label4.font = [UIFont systemFontOfSize:10];
    label5.font = [UIFont systemFontOfSize:10];
    label6.font = [UIFont systemFontOfSize:10];
    label7.font = [UIFont systemFontOfSize:10];
    label8.font = [UIFont systemFontOfSize:10];
    label1.backgroundColor = [UIColor clearColor];
    label2.backgroundColor = [UIColor clearColor];
    label3.backgroundColor = [UIColor clearColor];
    label4.backgroundColor = [UIColor clearColor];
    label5.backgroundColor = [UIColor clearColor];
    label6.backgroundColor = [UIColor clearColor];
    label7.backgroundColor = [UIColor clearColor];
    label8.backgroundColor = [UIColor clearColor];
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:label4];
    [self addSubview:label5];
    [self addSubview:label6];
    [self addSubview:label7];
    [self addSubview:label8];
    
    _ordercodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 100, 20)];
    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(215, 0, 85, 20)];
    _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 23, 100, 20)];
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 23, 100, 20)];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 46, 80, 20)];
    _telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 46, 100, 20)];
    _codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 69, 50, 20)];
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 69, 179, 20)];
    
        _ordercodeLabel.font = [UIFont systemFontOfSize:10];
        _stateLabel.font = [UIFont systemFontOfSize:10];
        _amountLabel.font = [UIFont systemFontOfSize:10];
        _dateLabel.font = [UIFont systemFontOfSize:10];
        _nameLabel.font = [UIFont systemFontOfSize:10];
        _telephoneLabel.font = [UIFont systemFontOfSize:10];
        _codeLabel.font = [UIFont systemFontOfSize:10];
        _addressLabel.font = [UIFont systemFontOfSize:10];
        
        _ordercodeLabel.backgroundColor = [UIColor clearColor];
        _stateLabel.backgroundColor = [UIColor clearColor];
        _amountLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _telephoneLabel.backgroundColor = [UIColor clearColor];
        _codeLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.backgroundColor = [UIColor clearColor];
        
        
        [self addSubview:_ordercodeLabel];
        [self addSubview:_stateLabel];
        [self addSubview:_amountLabel];
        [self addSubview:_dateLabel];
        [self addSubview:_nameLabel];
        [self addSubview:_telephoneLabel];
        [self addSubview:_codeLabel];
        [self addSubview:_addressLabel];
        
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
