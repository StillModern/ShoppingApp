//
//  MineViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    NSArray *_array;
    NSMutableArray *_orderArray;
}

@end
