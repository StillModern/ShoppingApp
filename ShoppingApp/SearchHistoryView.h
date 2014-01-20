//
//  SearchHistoryView.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchHistoryDelegate;

@interface SearchHistoryView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIButton *_buttonClean;
}

@property(nonatomic, assign) id<SearchHistoryDelegate> deleagate;
- (id)initWithFrame:(CGRect)frame;
- (void)resetTableView;

@end

@protocol SearchHistoryDelegate <NSObject>

- (void)swipeGestureRecognizer;
- (void)historySelect:(NSString *)searchText;

@end
