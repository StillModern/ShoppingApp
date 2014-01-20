//
//  TableViewShoppingCarCell.h
//  ShoppingApp
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShoppingCarDelegate;

@interface TableViewShoppingCarCell : UITableViewCell

@property(nonatomic, assign) id<ShoppingCarDelegate> delegate;
@property(nonatomic, retain) UIImageView *imageViewGood;
@property(nonatomic, retain) UILabel *labelName;
@property(nonatomic, retain) UIButton *buttonCount;
@property(nonatomic, retain) UILabel *labelPrice;
@property(nonatomic, retain) UILabel *labelAmount;
@property(nonatomic, retain) UIButton *buttonCheck;
//@property(nonatomic, assign) BOOL isCheck;

@end

@protocol ShoppingCarDelegate <NSObject>

- (void)buttonCountClick;
- (void)buttonCheckClick:(TableViewShoppingCarCell *)shoppingCarCell;

@end
