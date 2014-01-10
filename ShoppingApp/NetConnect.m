//
//  NetConnect.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "NetConnect.h"

@implementation NetConnect

- (id)init{
    self = [super init];
    if (self) {
        self.lRegister = [NSString stringWithFormat:@"http://%@/shop/register.php",KConnectIP];
        self.lLogin = [NSString stringWithFormat:@"http://%@/shop/login.php",KConnectIP];
        self.lCheckPassword = [NSString stringWithFormat:@"http://%@/shop/checkpassword.php",KConnectIP];
        self.lCheckName = [NSString stringWithFormat:@"http://%@/shop/checkname.php",KConnectIP];
        self.lCheckEmail = [NSString stringWithFormat:@"http://%@/shop/checkemail.php",KConnectIP];
        self.lCheckTelephone = [NSString stringWithFormat:@"http://%@/shop/checketelephone.php",KConnectIP];
        self.lChangePassword = [NSString stringWithFormat:@"http://%@/shop/changepassword.php",KConnectIP];
        self.lSearchGoods = [NSString stringWithFormat:@"http://%@/shop/searchgoods.php",KConnectIP];
        self.lHotGoods = [NSString stringWithFormat:@"http://%@/shop/hotgoods.php",KConnectIP];
        self.lGetGoods = [NSString stringWithFormat:@"http://%@/shop/getgoods.php",KConnectIP];
        self.lGetGoodInfo = [NSString stringWithFormat:@"http://%@/shop/getgoodsinfo.php",KConnectIP];
        self.lAddReview = [NSString stringWithFormat:@"http://%@/shop/addreview.php",KConnectIP];
        self.lGetReview = [NSString stringWithFormat:@"http://%@/shop/getreview.php",KConnectIP];
        self.lAddShoppingCar = [NSString stringWithFormat:@"http://%@/shop/addcart.php",KConnectIP];
        self.lGetShoppingCar = [NSString stringWithFormat:@"http://%@/shop/getcart.php",KConnectIP];
        self.lChangeShoppingCar = [NSString stringWithFormat:@"http://%@/shop/changecart.php",KConnectIP];
        self.lDeleteShoppingCar = [NSString stringWithFormat:@"http://%@/shop/deletecart.php",KConnectIP];
        self.lAddAddress = [NSString stringWithFormat:@"http://%@/shop/addaddress.php",KConnectIP];
        self.lGetAddress = [NSString stringWithFormat:@"http://%@/shop/getaddress.php",KConnectIP];
        self.lDeleteAddress = [NSString stringWithFormat:@"http://%@/shop/deleteaddress.php",KConnectIP];
        self.lAddOrder = [NSString stringWithFormat:@"http://%@/shop/addorder.php",KConnectIP];
        self.lGetOrder = [NSString stringWithFormat:@"http://%@/shop/getorder.php",KConnectIP];
        self.lDeleteOrder = [NSString stringWithFormat:@"http://%@/shop/deleteorder.php",KConnectIP];
        
        self.lGoodsImage = [NSString stringWithFormat:@"http://%@/shop/goodsimage/",KConnectIP];
        self.lGOOdsOtherInfo = [NSString stringWithFormat:@"http://%@/shop/html/",KConnectIP];
    }
    return self;
}

-(void)dealloc{
    [_lRegister release];
    [_lLogin release];
    [_lCheckPassword release];
    [_lCheckName release];
    [_lCheckEmail release];
    [_lCheckTelephone release];
    [_lChangePassword release];
    [_lSearchGoods release];
    [_lHotGoods release];
    [_lGetGoods release];
    [_lGetGoodInfo release];
    [_lAddReview release];
    [_lGetReview release];
    [_lAddShoppingCar release];
    [_lGetShoppingCar release];
    [_lChangeShoppingCar release];
    [_lDeleteShoppingCar release];
    [_lAddAddress release];
    [_lGetAddress release];
    [_lDeleteAddress release];
    [_lAddOrder release];
    [_lGetOrder release];
    [_lDeleteOrder release];
    
    [_lGoodsImage release];
    [_lGOOdsOtherInfo release];
    [super dealloc];
}

@end
