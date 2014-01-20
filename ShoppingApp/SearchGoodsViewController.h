//
//  SearchGoodsViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchHistoryView.h"

@interface SearchGoodsViewController : UIViewController<UISearchBarDelegate,SearchHistoryDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *_searchBar;
    SearchHistoryView *_searchHistory;
    NetConnect *_netConnect;
    NSOperationQueue *_operationQueue;
    NSMutableArray *_arrayShowGoods;
    UITableView *_tableView;
    UIView *_viewEmpty;
}

@property(nonatomic, retain) NSMutableString *searchText;

@end
