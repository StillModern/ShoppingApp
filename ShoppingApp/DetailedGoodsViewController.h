//
//  DetailedGoodsViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedGoodsViewController : UIViewController<UIScrollViewDelegate>
{
    NetConnect *_netConnect;
    NSOperationQueue *_operationQueue;
    UIImageView *_imageView;
    UILabel *_labelName;
    UILabel *_labelPrice;
    UILabel *_labelSellCount;
    UIScrollView *_scrollView;
    UISegmentedControl *_segmentedControl;
    UIWebView *_webViewIntroduction;
}

@end
