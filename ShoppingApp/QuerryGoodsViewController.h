//
//  QuerryGoodsViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryOrderViewCell.h"

@interface QuerryGoodsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
//    NSMutableDictionary *_dictionary;
    NSMutableArray *_array;
//    NSMutableDictionary *_goodsDictionary;
}
@property(nonatomic,retain) NSMutableDictionary *dictionary;
@property(nonatomic,retain) NSMutableArray *goodsArray;
@property(assign,nonatomic)BOOL isPush;
@end
