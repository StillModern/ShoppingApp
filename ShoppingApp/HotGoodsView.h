//
//  HotGoodsView.h
//  ShoppingApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HotGoodsViewDelegate;

@interface HotGoodsView : UIView

@property(nonatomic, copy) NSString *goodsID;
@property(nonatomic, assign) id<HotGoodsViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame AndDictionary:(NSDictionary *)dictionary;

@end

@protocol HotGoodsViewDelegate <NSObject>

- (void)tapGestureRecognizer:(HotGoodsView *)hotGoodsView;

@end