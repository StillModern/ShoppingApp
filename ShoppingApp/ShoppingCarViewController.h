//
//  ShoppingCarViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarViewController : UIViewController
{
    NetConnect *_netConnect;
    NSOperationQueue *_operationQueue;
    NSMutableArray *_arrayShoppingCar;
    UILabel *_labelCount;
    UIButton *_buttonBuy;
    UIView *_viewEmpty;
}
@end
