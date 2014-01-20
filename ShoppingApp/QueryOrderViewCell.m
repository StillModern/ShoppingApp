//
//  QueryOrderViewCell.m
//  ShoppingApp
//
//  Created by TY on 14-1-9.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "QueryOrderViewCell.h"

@implementation QueryGoodsViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor clearColor];
       
        
        UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 50, 20)]autorelease];
        label1.text = @"商品尺寸：";
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:10];
        [self addSubview:label1];
        
        UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(195, 40, 50, 20)]autorelease];
        label2.text = @"商品颜色：";
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:10];
        [self addSubview:label2];
        
        UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 50, 20)]autorelease];
        label3.text = @"商品数量：";
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:10];
        [self addSubview:label3];
        
        UILabel *label4 = [[[UILabel alloc]initWithFrame:CGRectMake(195, 60, 50, 20)]autorelease];
        label4.text = @"商品单价：";
        label4.backgroundColor = [UIColor clearColor];
        label4.font = [UIFont systemFontOfSize:10];
        [self addSubview:label4];
        
        UILabel *label5 = [[[UILabel alloc]initWithFrame:CGRectMake(195, 80, 35, 20)]autorelease];
        label5.text = @"价格：";
        label5.backgroundColor = [UIColor clearColor];
        label5.font = [UIFont systemFontOfSize:10];
        [self addSubview:label5];
        
        _orderimageView = [[[UIImageView alloc]initWithFrame:CGRectMake(13, 5, 75, 90)]autorelease];
        _orderimageView.layer.cornerRadius = 20;
        [self addSubview:_orderimageView];
        
        _nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 210, 40)]autorelease];
        _nameLabel.numberOfLines = 0;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor redColor];
        [self addSubview:_nameLabel];

        _goodscountLabel = [[[UILabel alloc]initWithFrame:CGRectMake(145, 60, 30, 20)]autorelease];
        _goodscountLabel.backgroundColor = [UIColor clearColor];
        _goodscountLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_goodscountLabel];
        
        _colorLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 40, 55, 20)]autorelease];
        _colorLabel.backgroundColor = [UIColor clearColor];
        _colorLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_colorLabel];
        
        _amonutLabel = [[[UILabel alloc]initWithFrame:CGRectMake(225, 80, 80, 20)]autorelease];
        _amonutLabel.backgroundColor = [UIColor clearColor];
        _amonutLabel.font = [UIFont systemFontOfSize:12];
        _amonutLabel.textColor = [UIColor blueColor];
        [self addSubview:_amonutLabel];
        
        _priceLabel = [[[UILabel alloc]initWithFrame:CGRectMake(240, 60, 55, 20)]autorelease];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_priceLabel];
        
        _sizeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(135, 40, 50, 20)]autorelease];
        _sizeLabel.backgroundColor = [UIColor clearColor];
        _sizeLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_sizeLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
