//
//  GoodsViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGoodsView.h"
#import "SearchHistoryView.h"

<<<<<<< HEAD
@interface GoodsViewController : UIViewController
- (IBAction)buttonClick:(UIButton *)sender;
=======
@interface GoodsViewController : UIViewController<UISearchBarDelegate,UIScrollViewDelegate,HotGoodsViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SearchHistoryDelegate>
{
    UISearchBar *_searchBar;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UICollectionView *_collectionView;
    NetConnect *_netConnect;
    NSOperationQueue *_operationQueue;
    NSMutableArray *_arrayAllGoods;
    SearchHistoryView *_searchHistory;
}
>>>>>>> 22c0af3f33e817379992d8efa43bd447fa43c721

@end
