//
//  SearchGoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "SearchGoodsViewController.h"
#import "SearchHistoryView.h"
#import "DetailedGoodsViewController.h"

@interface SearchGoodsViewController ()

@end

@implementation SearchGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"商品搜索";
        
        _searchText = [[NSMutableString alloc]init];
        _netConnect = [[NetConnect alloc]init];
        _operationQueue = [[NSOperationQueue alloc]init];
        _arrayShowGoods = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor magentaColor];    
    
    UIButton *lLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lLeftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [lLeftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lLeftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:lLeftButton];
    self.navigationItem.leftBarButtonItem = lLeftBarButtonItem;
    [lLeftButton release];
    [lLeftBarButtonItem release];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _searchBar.delegate = self;
    _searchBar.tintColor = [UIColor blueColor];
    _searchBar.text = _searchText;
    [self.view addSubview:_searchBar];
    
    NSArray *lArray = [NSArray arrayWithObjects:@"默认",@"价格",@"销量", nil];
    UISegmentedControl *lSegmentedControl = [[UISegmentedControl alloc]initWithItems:lArray];
    [lSegmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [lSegmentedControl setFrame:CGRectMake(155, 45, 160, 30)];
    [lSegmentedControl setSelectedSegmentIndex:0];
    [lSegmentedControl addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:lSegmentedControl];
    [lSegmentedControl release];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor cyanColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _viewEmpty = [[UIView alloc]initWithFrame:CGRectMake(320, 40, 320, 470)];
    [_viewEmpty setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:_viewEmpty];
    
    UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 280, 280)];
    [lImageView setImage:[UIImage imageNamed:@"empty.png"]];
    [_viewEmpty addSubview:lImageView];
    
    UILabel *lLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 360, 200, 25)];
    [lLabel setText:@"没有你想要搜索的商品"];
    [lLabel setTextAlignment:NSTextAlignmentCenter];
    [lLabel setTextColor:[UIColor blueColor]];
    [lLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [lLabel setBackgroundColor:[UIColor clearColor]];
    [_viewEmpty addSubview:lLabel];
    
    _searchHistory = [[SearchHistoryView alloc]initWithFrame:CGRectMake(0, 60, 320, 510)];
    _searchHistory.deleagate = self;
    [_searchHistory setFrame:CGRectMake(0, 570, 320, 510)];
    [self.navigationController.view addSubview:_searchHistory];
    
    [self setShowArry:_searchText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_searchBar release];
    [_searchText release];
    [_searchHistory release];
    [_netConnect release];
    [_operationQueue release];
    [_arrayShowGoods release];
    [_tableView release];
    [_viewEmpty release];
    [super dealloc];
}

- (void)leftButtonClick:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView beginAnimations:@"animation" context:nil];
    [_searchBar setText:nil];
    [_searchHistory setFrame:CGRectMake(0, 105, 320, 510)];
    _searchBar.showsCancelButton = YES;
    [UIView commitAnimations];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [UIView beginAnimations:@"animation" context:nil];
    [_searchHistory setFrame:CGRectMake(0, 570, 320, 510)];
    [UIView commitAnimations];
    
    if (searchText != nil && ![searchText isEqualToString:@""]) {
        [self setShowArry:searchText];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    if (_searchBar.text != nil && ![_searchBar.text isEqualToString:@""]) {
        [_searchText setString:_searchBar.text];
        [[ShoppingManager shareShoppingManager].arrayHistory addObject:searchBar.text];
        [_searchHistory resetTableView];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [[ShoppingManager shareShoppingManager].arrayHistory addObject:searchBar.text];
    [_searchHistory resetTableView];
    [self setSearchHistory];
    [_searchText setString:searchBar.text];
    [self setShowArry:searchBar.text];
}

- (void)swipeGestureRecognizer{
    [self setSearchHistory];
    if (_searchBar.text != nil && ![_searchBar.text isEqualToString:@""]) {
        [_searchText setString:_searchBar.text];;
    }
}

- (void)historySelect:(NSString *)searchText{
    [self setSearchHistory];
    [_searchBar setText:searchText];
    [_searchText setString:searchText];
    [self setShowArry:searchText];
}

- (void)setSearchHistory{
    [UIView beginAnimations:@"animation" context:nil];
    [_searchBar resignFirstResponder];
    [_searchHistory setFrame:CGRectMake(0, 570, 320, 510)];
    [UIView commitAnimations];
}

- (void)segmentedChange:(UISegmentedControl *)sender{
    NSURL *lURLSearchGoods = [NSURL URLWithString:_netConnect.lSearchGoods];
    NSMutableURLRequest *lRequestSearchGoods = [NSMutableURLRequest requestWithURL:lURLSearchGoods];
    NSString *lStrBody;
    switch (sender.selectedSegmentIndex) {
        case 0:{
            lStrBody = [NSString stringWithFormat:@"search=%@&type=0&order=0&owncount=0",_searchText];
        }
            break;
        case 1:{
            lStrBody = [NSString stringWithFormat:@"search=%@&type=0&order=1&owncount=0",_searchText];
        }
            break;
        case 2:{
            lStrBody = [NSString stringWithFormat:@"search=%@&type=1&order=1&owncount=0",_searchText];
        }
            break;
    }
    [lRequestSearchGoods setHTTPMethod:KHTTPMETHOD];
    [lRequestSearchGoods setHTTPBody:[lStrBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestSearchGoods queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicAllGoods = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicAllGoods objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicAllGoods objectForKey:KMSG];
                    NSString *lStrCount = [lDicMsg objectForKey:KCount];
                    if ([lStrCount intValue] == 0) {
                        [_viewEmpty setFrame:CGRectMake(0, 40, 320, 470)];
                    } else {
                        [_arrayShowGoods removeAllObjects];
                        [_arrayShowGoods addObjectsFromArray:[lDicMsg objectForKey:KINFOS]];
                        [_viewEmpty setFrame:CGRectMake(320, 40, 320, 470)];
                        [_tableView reloadData];
                    }
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self warning];
                    });
                }
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self warning];
            });
        }
    }];
}

- (void)setShowArry:(NSString *)searchText{    
    
    NSURL *lURLSearchGoods = [NSURL URLWithString:_netConnect.lSearchGoods];
    NSMutableURLRequest *lRequestSearchGoods = [NSMutableURLRequest requestWithURL:lURLSearchGoods];
    NSString *lStrBody = [NSString stringWithFormat:@"search=%@&type=0&order=0&owncount=0",searchText];
    [lRequestSearchGoods setHTTPMethod:KHTTPMETHOD];
    [lRequestSearchGoods setHTTPBody:[lStrBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestSearchGoods queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicAllGoods = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicAllGoods objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicAllGoods objectForKey:KMSG];
                    NSString *lStrCount = [lDicMsg objectForKey:KCount];
                    if ([lStrCount intValue] == 0) {
                        [_viewEmpty setFrame:CGRectMake(0, 40, 320, 470)];
                    } else {
                        [_arrayShowGoods removeAllObjects];
                        [_arrayShowGoods addObjectsFromArray:[lDicMsg objectForKey:KINFOS]];
                        [_viewEmpty setFrame:CGRectMake(320, 40, 320, 470)];
                        [_tableView reloadData];
                    }                 
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self warning];
                    });
                }
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self warning];
            });
        }
    }];    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayShowGoods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellIdentifier = KCELLIDENTIFIER;
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier]autorelease];
    }
    lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSInteger row = [indexPath row];
    NSDictionary *lDicGoodsInfo = [_arrayShowGoods objectAtIndex:row];
    
    [lCell.imageView setImage:[UIImage imageNamed:@"empty.png"]];
    NSString *lImagePath = [_netConnect.lGoodsImage stringByAppendingString:[lDicGoodsInfo objectForKey:KIMAGE]];
    NSURL *lURL = [NSURL URLWithString:lImagePath];
    NSURLRequest *lRequest = [NSURLRequest requestWithURL:lURL];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *lImage = [UIImage imageWithData:lData];
                [lCell.imageView setImage:lImage];
            });
        }
    }];
    
    [lCell.textLabel setNumberOfLines:0];
    lCell.textLabel.text = [lDicGoodsInfo objectForKey:KNAME];
    
    return lCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSDictionary *lDicGoodsInfo = [_arrayShowGoods objectAtIndex:row];
    [ShoppingManager shareShoppingManager].goodsId = [lDicGoodsInfo objectForKey:KGOODSID];
    
    DetailedGoodsViewController *lDetailed = [[DetailedGoodsViewController alloc]init];
    [self.navigationController pushViewController:lDetailed animated:YES];
    [lDetailed release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)warning{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-200, 280, 60)];
    [label setBackgroundColor:[UIColor blackColor]];
    [label setText:@"获取数据失败～～～"];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont boldSystemFontOfSize:25]];
    [self.view addSubview:label];
    [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
    [label release];
}

- (void)removeLabel:(UILabel *)sender{
    [sender removeFromSuperview];
}

@end
