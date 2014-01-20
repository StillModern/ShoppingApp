//
//  AppraiseGoodsViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppraiseGoodsViewController : UIViewController{
    
    UIImageView *_imageView;
    UITextField *_lTextField;
    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    UIButton *_button4;
    UIButton *_button5;
    BOOL _isbutton1;
    BOOL _isbutton2;
    BOOL _isbutton3;
    BOOL _isbutton4;
    BOOL _isbutton5;
}
@property(nonatomic,retain) NSMutableDictionary *dictionary;
@end
