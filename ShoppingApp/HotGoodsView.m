//
//  HotGoodsView.m
//  ShoppingApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "HotGoodsView.h"

@implementation HotGoodsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndDictionary:(NSDictionary *)dictionary{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 280, 130)];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        self.goodsID = [dictionary objectForKey:KGOODSID];
        
        UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 120, 120)];        
        NetConnect *lNetConnect = [[NetConnect alloc]init];
        NSString *lImagePath = [lNetConnect.lGoodsImage stringByAppendingString:[dictionary objectForKey:KIMAGE]];
        NSURL *lURL = [NSURL URLWithString:lImagePath];        
        NSURLRequest *lRequest = [NSURLRequest requestWithURL:lURL];
        NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];        
        [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
            if (lError == nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIImage *lImage = [UIImage imageWithData:lData];
                    [lImageView setImage:lImage];
                });                
            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIImage *lImage = [UIImage imageNamed:@"empty.png"];
                    [lImageView setImage:lImage];
                });
            }
        }];              
        [self addSubview:lImageView];
        [lNetConnect release];
        [lOperationQueue release];
        [lImageView release];
        
        UILabel *lLabelName = [[UILabel alloc]initWithFrame:CGRectMake(135, 10, 140, 80)];
        [lLabelName setText:[dictionary objectForKey:KNAME]];
        [lLabelName setTextColor:[UIColor blueColor]];
        [lLabelName setTextAlignment:NSTextAlignmentCenter];
        [lLabelName setFont:[UIFont boldSystemFontOfSize:15]];
        [lLabelName setNumberOfLines:4];
        [lLabelName setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lLabelName];
        [lLabelName release];
        
        UILabel *lLabelPrice = [[UILabel alloc]initWithFrame:CGRectMake(150, 100, 110, 20)];
        [lLabelPrice setText:[NSString stringWithFormat:@"￥%@",[dictionary objectForKey:KPRICE]]];
        [lLabelPrice setTextColor:[UIColor redColor]];
        [lLabelPrice setFont:[UIFont boldSystemFontOfSize:20]];
        [lLabelPrice setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lLabelPrice];
        [lLabelPrice release];
        
        UITapGestureRecognizer *lTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self addGestureRecognizer:lTapGestureRecognizer];
        [lTapGestureRecognizer release];
    }
    return self;
}

- (void)dealloc{
    [_goodsID release];
    [super dealloc];
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)sender{
    [_delegate tapGestureRecognizer:self];
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
