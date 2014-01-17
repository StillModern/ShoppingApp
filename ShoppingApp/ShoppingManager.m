//
//  ShoppingManager.m
//  ShoppingApp
//
//  Created by TY on 14-1-10.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "ShoppingManager.h"

static ShoppingManager *shareShoppingManager = nil;

@implementation ShoppingManager

+ (ShoppingManager *)shareShoppingManager{
    @synchronized(self){
        if (shareShoppingManager == nil) {
            shareShoppingManager = [[ShoppingManager alloc]init];
        }
    }
    return shareShoppingManager;
}

- (id)init{
    self = [super init];
    if (self) {
        _isLogin = NO;
        _coustomerid = @"3";
        _goodsId = nil;
        _arrayHistory = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
