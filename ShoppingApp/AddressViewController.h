//
//  AddressViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>{
    NSArray *_array;
    NSMutableData *_data;
    UITableView *_tableView;
    
}
@property(nonatomic,retain)NSMutableDictionary *dictionary;
//@property(nonatomic,assign)BOOL isButtonClick;
@end
