//
//  GoodsViewController.h
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGoodsView.h"

@interface GoodsViewController : UIViewController<UISearchBarDelegate,UIScrollViewDelegate,HotGoodsViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UICollectionView *_collectionView;
    NetConnect *_netConnect;
    NSOperationQueue *_operationQueue;
    NSMutableArray *_arrayAllGoods;
}

@end
