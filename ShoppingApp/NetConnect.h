//
//  NetConnect.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetConnect : NSObject

@property(nonatomic, copy) NSString *lRegister; //注册
@property(nonatomic, copy) NSString *lLogin; //登陆
@property(nonatomic, copy) NSString *lCheckPassword; //检查密码是否有效
@property(nonatomic, copy) NSString *lCheckName; //检查用户名是否有效
@property(nonatomic, copy) NSString *lCheckEmail; //检查邮箱是否有效
@property(nonatomic, copy) NSString *lCheckTelephone; //检查电话号码是否有效
@property(nonatomic, copy) NSString *lChangePassword; //修改密码
@property(nonatomic, copy) NSString *lSearchGoods; //搜索商品
@property(nonatomic, copy) NSString *lHotGoods; //热门商品
@property(nonatomic, copy) NSString *lGetGoods; //查看全部商品
@property(nonatomic, copy) NSString *lGetGoodInfo; //查看商品详细信息
@property(nonatomic, copy) NSString *lAddReview; //添加评论
@property(nonatomic, copy) NSString *lGetReview; //查看评论
@property(nonatomic, copy) NSString *lAddShoppingCar; //添加到购物车
@property(nonatomic, copy) NSString *lGetShoppingCar; //查看购物车
@property(nonatomic, copy) NSString *lChangeShoppingCar; //修改购物车
@property(nonatomic, copy) NSString *lDeleteShoppingCar; //删除购物车
@property(nonatomic, copy) NSString *lAddAddress; //添加地址
@property(nonatomic, copy) NSString *lGetAddress; //查看地址
@property(nonatomic, copy) NSString *lDeleteAddress; //删除地址
@property(nonatomic, copy) NSString *lAddOrder; //提交订单
@property(nonatomic, copy) NSString *lGetOrder; //查看订单
@property(nonatomic, copy) NSString *lDeleteOrder; //删除订单

@property(nonatomic, copy) NSString *lGoodsImage; //商品图片
@property(nonatomic, copy) NSString *lGOOdsOtherInfo; //商品的其它四个文件

@end
