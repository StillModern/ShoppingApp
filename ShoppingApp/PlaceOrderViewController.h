//
//  PlaceOrderViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *_scrollView;
}
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *telphoneLabel;
@property(nonatomic,retain)UILabel *codeLabel;
@property(nonatomic,retain)UILabel *addressLabel;
@end
