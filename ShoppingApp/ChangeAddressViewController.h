//
//  ChangeAddressViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAddressViewController : UIViewController
@property(assign,nonatomic)BOOL isAdd;
@property(nonatomic,retain)UITextField *addressTextField;
@property(nonatomic,retain)UITextField *nameTextField;
@property(nonatomic,retain)UITextField *telephoneTextField;
@property(nonatomic,retain)UITextField *codeTextField;
@property(nonatomic,retain)NSMutableDictionary *showDictionary;
@end
