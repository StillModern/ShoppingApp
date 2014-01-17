//
//  ShoppingManager.h
//  ShoppingApp
//
//  Created by TY on 14-1-10.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingManager : NSObject

@property(nonatomic, assign) BOOL isLogin;
@property(nonatomic, copy) NSString *coustomerid;
@property(nonatomic, copy) NSString *goodsId;
@property(nonatomic, retain) NSMutableArray *arrayHistory;

+ (ShoppingManager *)shareShoppingManager;

@end
