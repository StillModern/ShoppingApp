//
//  GoodsOrdermessge.m
//  ShoppingApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "GoodsOrdermessge.h"

@implementation GoodsOrdermessge

- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *lImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 50)]autorelease];
        [self addSubview:lImageView];
        
        UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 50, 30)]autorelease];
        label1.text = @"商品:";
        [self addSubview:label1];
        
        UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(160, 15, 50, 20)]autorelease];
        label2.text = @"数量：";
        [self addSubview:label2];
        
        UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(240, 15, 50, 30)]autorelease];
        label3.text = @"价格：";
        [self addSubview:label3];
        
    }
    return self;
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
