//
//  GoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "GoodsViewController.h"
#import "HotGoodsView.h"
#import "CustomCollectionViewCell.h"
#import "DetailedGoodsViewController.h"

@interface GoodsViewController ()

@end

@implementation GoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"商品";
        _netConnect = [[NetConnect alloc]init];
        _operationQueue = [[NSOperationQueue alloc]init];
        _arrayAllGoods = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor magentaColor];
    
    UISearchBar *lSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    lSearchBar.delegate = self;
    lSearchBar.showsCancelButton = YES;
    lSearchBar.tintColor = [UIColor blueColor];
    [self.view addSubview:lSearchBar];
    [lSearchBar release];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 50, 280, 130)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(35, 150, 150, 36)];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [_pageControl addTarget:self action:@selector(currentPageChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];    
    
    NSURL *lURlHotGoods = [NSURL URLWithString:_netConnect.lHotGoods];
    NSURLRequest *lRequestHotGoods = [NSURLRequest requestWithURL:lURlHotGoods];    
    [NSURLConnection sendAsynchronousRequest:lRequestHotGoods queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {            
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicHotGoods = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];                
                NSArray *lArrayHotGoods = [lDicHotGoods objectForKey:KMSG];
                [_scrollView setContentSize:CGSizeMake(280*lArrayHotGoods.count, 130)];
                _pageControl.numberOfPages = lArrayHotGoods.count;                
                for (int i=0; i<lArrayHotGoods.count; i++) {
                    HotGoodsView *lHotGoodsView = [[HotGoodsView alloc]initWithFrame:CGRectMake(280*i, 0, 280, 130) AndDictionary:[lArrayHotGoods objectAtIndex:i]];
                    lHotGoodsView.delegate = self;
                    [_scrollView addSubview:lHotGoodsView];
                    [lHotGoodsView release];
                }  
            });            
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-200, 280, 60)];
                [label setBackgroundColor:[UIColor blackColor]];
                [label setText:@"获取数据数据～～～"];
                [label setTextColor:[UIColor whiteColor]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setFont:[UIFont boldSystemFontOfSize:25]];
                [self.view addSubview:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                [label release];
            });
        }
    }];
    
    NSArray *lArray = [NSArray arrayWithObjects:@"默认",@"价格",@"销量", nil];
    UISegmentedControl *lSegmentedControl = [[UISegmentedControl alloc]initWithItems:lArray];
    [lSegmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [lSegmentedControl setFrame:CGRectMake(140, 185, 160, 30)];
    [lSegmentedControl setSelectedSegmentIndex:0];
    [lSegmentedControl addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:lSegmentedControl];
    [lSegmentedControl release];
    
    NSURL *lURLAllGoods = [NSURL URLWithString:_netConnect.lGetGoods];
    NSMutableURLRequest *lRequestAllGoods = [NSMutableURLRequest requestWithURL:lURLAllGoods];
    NSString *lStringBody = @"type=0&order=0&owncount=0";
    [lRequestAllGoods setHTTPMethod:KHTTPMETHOD];
    [lRequestAllGoods setHTTPBody:[lStringBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestAllGoods queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicAllGoods = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicAllGoods objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicAllGoods objectForKey:KMSG];
                    [_arrayAllGoods removeAllObjects];
                    [_arrayAllGoods addObjectsFromArray:[lDicMsg objectForKey:KINFOS]];
                    [_collectionView reloadData];
                }else{
                    
                }
            });
        } else {
            
        }
    }];
    
    
    UICollectionViewFlowLayout *lCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    lCollectionViewFlowLayout.itemSize = CGSizeMake(80, 80);
    lCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    lCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 220, 280, 270) collectionViewLayout:lCollectionViewFlowLayout];
    _collectionView.backgroundColor = [UIColor cyanColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:KCELLIDENTIFIER];
    [self.view addSubview:_collectionView];
    [lCollectionViewFlowLayout release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_scrollView release];
    [_pageControl release];
    [_collectionView release];
    [_netConnect release];
    [_operationQueue release];
    [_arrayAllGoods release];
    [super dealloc];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = _scrollView.contentOffset;
    CGRect rect = _scrollView.frame;
    [_pageControl setCurrentPage:offset.x/rect.size.width];
}

- (void)currentPageChange:(UIPageControl *)sender{
    CGSize size = _scrollView.frame.size;
    CGRect rect = CGRectMake(size.width*sender.currentPage, _scrollView.frame.origin.y, size.width, size.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
}

- (void)tapGestureRecognizer:(HotGoodsView *)hotGoodsView{
    [ShoppingManager shareShoppingManager].goodsId = hotGoodsView.goodsID;
    DetailedGoodsViewController *lDetailed = [[DetailedGoodsViewController alloc]init];
    UINavigationController *lNavigation = [[UINavigationController alloc]initWithRootViewController:lDetailed];
    lNavigation.navigationBar.tintColor = [UIColor blueColor];
    [lNavigation setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self.tabBarController presentViewController:lNavigation animated:YES completion:nil];
    [lDetailed release];
    [lNavigation release];
}

- (void)segmentedChange:(UISegmentedControl *)sender{
    NSURL *lURLAllGoods = [NSURL URLWithString:_netConnect.lGetGoods];
    NSMutableURLRequest *lRequestAllGoods = [NSMutableURLRequest requestWithURL:lURLAllGoods];    
    NSString *lStrBody;
    switch (sender.selectedSegmentIndex) {
        case 0:{
            lStrBody = @"type=0&order=0&owncount=0";
        }
            break;
        case 1:{
            lStrBody = @"type=0&order=1&owncount=0";
        }
            break;
        case 2:{
            lStrBody = @"type=1&order=1&owncount=0";
        }
            break;
    }    
    [lRequestAllGoods setHTTPMethod:KHTTPMETHOD];
    [lRequestAllGoods setHTTPBody:[lStrBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestAllGoods queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicAllGoods = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicAllGoods objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicAllGoods objectForKey:KMSG];
                    [_arrayAllGoods removeAllObjects];
                    [_arrayAllGoods addObjectsFromArray:[lDicMsg objectForKey:KINFOS]];
                    [_collectionView reloadData];
                }else{
                    
                }
            });
        } else {
            
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayAllGoods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *lCell = [collectionView dequeueReusableCellWithReuseIdentifier:KCELLIDENTIFIER forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    NSDictionary *lDicGoodsInfo = [_arrayAllGoods objectAtIndex:row];
    
    [lCell.imgaeView setImage:[UIImage imageNamed:@"empty.png"]];
    NSString *lImagePath = [_netConnect.lGoodsImage stringByAppendingString:[lDicGoodsInfo objectForKey:KIMAGE]];
    NSURL *lURL = [NSURL URLWithString:lImagePath];
    NSURLRequest *lRequest = [NSURLRequest requestWithURL:lURL];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *lImage = [UIImage imageWithData:lData];
                [lCell.imgaeView setImage:lImage];
            });
        }
    }];
    
    [lCell.labelName setText:[lDicGoodsInfo objectForKey:KNAME]];
    [lCell.labelPrice setText:[NSString stringWithFormat:@"￥%@",[lDicGoodsInfo objectForKey:KPRICE]]];
    
    return lCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSDictionary *lDicGoodsInfo = [_arrayAllGoods objectAtIndex:row];
    [ShoppingManager shareShoppingManager].goodsId = [lDicGoodsInfo objectForKey:KGOODSID];
    DetailedGoodsViewController *lDetailed = [[DetailedGoodsViewController alloc]init];
    UINavigationController *lNavigation = [[UINavigationController alloc]initWithRootViewController:lDetailed];
    lNavigation.navigationBar.tintColor = [UIColor blueColor];
    [lNavigation setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self.tabBarController presentViewController:lNavigation animated:YES completion:nil];
    [lDetailed release];
    [lNavigation release];
}

- (void)removeLabel:(UILabel *)sender{
    [sender removeFromSuperview];
}

@end
