//
//  DetailedGoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "DetailedGoodsViewController.h"
#import "TableViewReViewCell.h"

@interface DetailedGoodsViewController ()

@end

@implementation DetailedGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"商品详情";
        _netConnect = [[NetConnect alloc]init];
        _operationQueue = [[NSOperationQueue alloc]init];
        _arrayStar = [[NSMutableArray alloc]init];
        _arrayReview = [[NSMutableArray alloc]init];
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
    
    UIButton *lButtonBuy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButtonBuy setFrame:CGRectMake(0, 464, 160, 40)];
    [lButtonBuy setTitle:@"立即购买" forState:UIControlStateNormal];
    [lButtonBuy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [lButtonBuy addTarget:self action:@selector(buttonBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButtonBuy];
    
    UIButton *lButtonAddToCar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButtonAddToCar setFrame:CGRectMake(160, 464, 160, 40)];
    [lButtonAddToCar setTitle:@"添加到购物车" forState:UIControlStateNormal];
    [lButtonAddToCar setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [lButtonAddToCar addTarget:self action:@selector(buttonAddToCarClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButtonAddToCar];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer *lTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [_imageView addGestureRecognizer:lTapGestureRecognizer];
    [lTapGestureRecognizer release];
    
    _labelName = [[UILabel alloc]initWithFrame:CGRectMake(140, 20, 160, 65)];
    [_labelName setTextAlignment:NSTextAlignmentCenter];
    [_labelName setTextColor:[UIColor blueColor]];
    [_labelName setNumberOfLines:3];
    [_labelName setFont:[UIFont boldSystemFontOfSize:18]];
    [_labelName setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelName];
    
    _labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(140, 90, 100, 25)];
    [_labelPrice setTextAlignment:NSTextAlignmentLeft];
    [_labelPrice setTextColor:[UIColor blackColor]];
    [_labelPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [_labelPrice setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelPrice];
    
    _labelSellCount = [[UILabel alloc]initWithFrame:CGRectMake(230, 90, 70, 25)];
    [_labelSellCount setTextAlignment:NSTextAlignmentRight];
    [_labelSellCount setTextColor:[UIColor cyanColor]];
    [_labelSellCount setFont:[UIFont boldSystemFontOfSize:18]];
    [_labelSellCount setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelSellCount];
    
    NSArray *lArray = [NSArray arrayWithObjects:@"商品介绍",@"详细参数",@"评论",@"售后服务", nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:lArray];
    [_segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [_segmentedControl setFrame:CGRectMake(0, 135, 320, 30)];
    [_segmentedControl setSelectedSegmentIndex:0];
    [_segmentedControl addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 164, 320, 300)];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width*4, _scrollView.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollView];
    
    UIView *lViewIntroduction = [[UIView alloc]initWithFrame:CGRectMake(320*0, 0, 320, 300)];
    [lViewIntroduction setBackgroundColor:[UIColor cyanColor]];
    [_scrollView addSubview:lViewIntroduction];
    
    _labelColor = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 130, 25)];
    [_labelColor setTextColor:[UIColor blueColor]];
    [_labelColor setFont:[UIFont boldSystemFontOfSize:20]];
    [_labelColor setBackgroundColor:[UIColor clearColor]];
    [lViewIntroduction addSubview:_labelColor];
    
    _labelSize = [[UILabel alloc]initWithFrame:CGRectMake(160, 20, 140, 25)];
    [_labelSize setTextColor:[UIColor magentaColor]];
    [_labelSize setTextAlignment:NSTextAlignmentRight];
    [_labelSize setFont:[UIFont boldSystemFontOfSize:20]];
    [_labelSize setBackgroundColor:[UIColor clearColor]];
    [lViewIntroduction addSubview:_labelSize];
    
    UILabel *lLabelStar = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, 70, 25)];
    [lLabelStar setText:@"总评价:"];
    [lLabelStar setTextColor:[UIColor redColor]];
    [lLabelStar setFont:[UIFont boldSystemFontOfSize:20]];
    [lLabelStar setBackgroundColor:[UIColor clearColor]];
    [lViewIntroduction addSubview:lLabelStar];
    
    for (int i=0; i<5; i++) {
        UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(95+30*i, 65, 25, 25)];
        [_arrayStar addObject:lImageView];
        [lViewIntroduction addSubview:lImageView];
    }
    
    UILabel *lLabelList = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 90, 25)];
    [lLabelList setText:@"包装清单:"];
    [lLabelList setFont:[UIFont boldSystemFontOfSize:20]];
    [lLabelList setBackgroundColor:[UIColor clearColor]];
    [lViewIntroduction addSubview:lLabelList];
    
    _webPackinglist = [[UIWebView alloc]initWithFrame:CGRectMake(20, 140, 280, 140)];
    [_webPackinglist setBackgroundColor:[UIColor cyanColor]];
    [lViewIntroduction addSubview:_webPackinglist];
    
    _webViewSpecifications = [[UIWebView alloc]initWithFrame:CGRectMake(320*1, 0, 320, 300)];
    [_webViewSpecifications setBackgroundColor:[UIColor cyanColor]];
    [_scrollView addSubview:_webViewSpecifications];
    
    _tabelViewReview = [[UITableView alloc]initWithFrame:CGRectMake(320*2, 0, 320, 300) style:UITableViewStylePlain];
    _tabelViewReview.separatorColor = [UIColor blueColor];
    _tabelViewReview.dataSource = self;
    _tabelViewReview.delegate = self;
    _tabelViewReview.backgroundColor = [UIColor cyanColor];
    
    _viewReview = [[UIView alloc]initWithFrame:CGRectMake(320*2, 0, 320, 300)];
    [_viewReview setBackgroundColor:[UIColor cyanColor]];
    
    UIImageView *lImageViewEmpty = [[UIImageView alloc]initWithFrame:CGRectMake(60, 20, 200, 200)];
    [lImageViewEmpty setImage:[UIImage imageNamed:@"empty.png"]];
    [_viewReview addSubview:lImageViewEmpty];
    [lImageViewEmpty release];
    
    UILabel *lLabelEmpty = [[UILabel alloc]initWithFrame:CGRectMake(50, 235, 210, 30)];
    [lLabelEmpty setText:@"暂无商品评论信息"];
    [lLabelEmpty setTextAlignment:NSTextAlignmentCenter];
    [lLabelEmpty setTextColor:[UIColor blueColor]];
    [lLabelEmpty setFont:[UIFont boldSystemFontOfSize:25]];
    [lLabelEmpty setBackgroundColor:[UIColor clearColor]];
    [_viewReview addSubview:lLabelEmpty];
    [lLabelEmpty release];
    
    _webService = [[UIWebView alloc]initWithFrame:CGRectMake(320*3, 0, 320, 300)];
    [_webViewSpecifications setBackgroundColor:[UIColor clearColor]];
    [_scrollView addSubview:_webService];
    
    [self getGoodsInfo];
    [self setScrollViewInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_operationQueue release];
    [_imageView release];
    [_labelName release];
    [_labelPrice release];
    [_labelSellCount release];
    [_scrollView release];
    [_segmentedControl release];
    [_webViewIntroduction release];
    [_arrayReview release];
    [_labelColor release];
    [_labelSize release];
    [_arrayStar release];
    [_webPackinglist release];
    [_webViewSpecifications release];
    [_tabelViewReview release];
    [_viewReview release];
    [_webService release];
    [super dealloc];
}

- (void)getGoodsInfo{
    NSURL *lURLAllGoods = [NSURL URLWithString:_netConnect.lGetGoodInfo];
    NSMutableURLRequest *lRequestAllGoods = [NSMutableURLRequest requestWithURL:lURLAllGoods];
    NSString *lStringBody = [NSString stringWithFormat:@"goodsid=%@",[ShoppingManager shareShoppingManager].goodsId];
    [lRequestAllGoods setHTTPMethod:KHTTPMETHOD];
    [lRequestAllGoods setHTTPBody:[lStringBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestAllGoods queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicGoodsInfo = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicGoodsInfo objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicGoodsInfo objectForKey:KMSG];
                    [self setGoodsInfo:lDicMsg];                    
                }else{
                    
                }
            });
        } else {
            
        }
    }];
}

- (void)setGoodsInfo:(NSDictionary *)dictionary{
    NSString *lImagePath = [_netConnect.lGoodsImage stringByAppendingString:[dictionary objectForKey:KIMAGE]];
    NSURL *lURL = [NSURL URLWithString:lImagePath];
    NSURLRequest *lRequest = [NSURLRequest requestWithURL:lURL];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *lImage = [UIImage imageWithData:lData];
                [_imageView setImage:lImage];
            });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *lImage = [UIImage imageNamed:@"empty.png"];
                [_imageView setImage:lImage];
            });
        }
    }];    
    
    [_labelName setText:[dictionary objectForKey:KNAME]];
    [_labelPrice setText:[NSString stringWithFormat:@"￥%@",[dictionary objectForKey:KPRICE]]];
    [_labelSellCount setText:[NSString stringWithFormat:@"销量 %@",[dictionary objectForKey:KSELLCOUNT]]];
    
    [_labelColor setText:[NSString stringWithFormat:@"颜色:%@",[dictionary objectForKey:KCOLOR]]];
    [_labelSize setText:[NSString stringWithFormat:@"型号:%@",[dictionary objectForKey:KSIZE]]];
    
    for (int i=1; i<=5; i++) {
        UIImageView *lImageView = [_arrayStar objectAtIndex:i-1];
        NSString *lStrStar = [dictionary objectForKey:KSTAR];
        double star = [lStrStar doubleValue];
        if (i < star) {
            [lImageView setImage:[UIImage imageNamed:@"star_light.png"]];
        } else if (i < star+0.5) {
            [lImageView setImage:[UIImage imageNamed:@"star_half.png"]];
        } else {
            [lImageView setImage:[UIImage imageNamed:@"star.png"]];
        }
    }
}

- (void)setScrollViewInfo{
    [self getGoodsReview];
    
    NSURL *lURLPackinglist = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",_netConnect.lGOOdsOtherInfo,[ShoppingManager shareShoppingManager].goodsId,KPACKINGLIST]];
    NSURLRequest *lRequestPackinglist = [NSURLRequest requestWithURL:lURLPackinglist];
    [_webPackinglist loadRequest:lRequestPackinglist];
    
    NSURL *lURLSpecifications = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",_netConnect.lGOOdsOtherInfo,[ShoppingManager shareShoppingManager].goodsId,KSPECIFICATIONS]];
    NSURLRequest *lRequestSpecifications = [NSURLRequest requestWithURL:lURLSpecifications];
    [_webViewSpecifications loadRequest:lRequestSpecifications];
    
    NSURL *lURLService = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",_netConnect.lGOOdsOtherInfo,[ShoppingManager shareShoppingManager].goodsId,KSERVICE]];
    NSURLRequest *lRequestService = [NSURLRequest requestWithURL:lURLService];
    [_webService loadRequest:lRequestService];
}

- (void)getGoodsReview{
    NSURL *lURLReview = [NSURL URLWithString:_netConnect.lGetReview];
    NSMutableURLRequest *lRequestReview = [NSMutableURLRequest requestWithURL:lURLReview];
    NSString *lStringBody = [NSString stringWithFormat:@"goodsid=%@&owncount=%i",[ShoppingManager shareShoppingManager].goodsId,0];
    [lRequestReview setHTTPMethod:KHTTPMETHOD];
    [lRequestReview setHTTPBody:[lStringBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestReview queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicGoodsReview = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicGoodsReview objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicGoodsReview objectForKey:KMSG];
                    [_arrayReview addObjectsFromArray:[lDicMsg objectForKey:KINFOS]];
                    [_segmentedControl setTitle:[NSString stringWithFormat:@"评论 %@",[lDicMsg objectForKey:KCount]] forSegmentAtIndex:2];
                    if (_arrayReview.count == 0) {
                        [_scrollView addSubview:_viewReview];
                    } else {
                        [_scrollView addSubview:_tabelViewReview];
                    }
                }else{
                    
                }
            });
        } else {
            
        }
    }];
}

- (void)leftButtonClick:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)sender{
    _webViewIntroduction = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    _webViewIntroduction.alpha = 0.8;
    NSURL *lURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",_netConnect.lGOOdsOtherInfo,[ShoppingManager shareShoppingManager].goodsId,KINTRODUCTION]];
    NSURLRequest *lRequest = [NSURLRequest requestWithURL:lURL];
    [_webViewIntroduction loadRequest:lRequest];
    [self.navigationController.view addSubview:_webViewIntroduction];
    
    UIButton *lButtonDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    [lButtonDismiss setFrame:CGRectMake(300, 0, 20, 20)];
    [lButtonDismiss setTitle:@"X" forState:UIControlStateNormal];
    [lButtonDismiss setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lButtonDismiss setBackgroundColor:[UIColor redColor]];
    [lButtonDismiss addTarget:self action:@selector(buttonDismissClick:) forControlEvents:UIControlEventTouchUpInside];
    [_webViewIntroduction addSubview:lButtonDismiss];
}

- (void)segmentedChange:(UISegmentedControl *)sender{
    CGSize size = _scrollView.frame.size;
    CGRect rect = CGRectMake(size.width*sender.selectedSegmentIndex, _scrollView.frame.origin.y, size.width, size.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = _scrollView.contentOffset;
    CGRect rect = _scrollView.frame;
    [_segmentedControl setSelectedSegmentIndex:offset.x/rect.size.width];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayReview.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellIdentifier = KCELLIDENTIFIER;
    TableViewReViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    if (lCell == nil) {
        lCell = [[[TableViewReViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier]autorelease];
    }
    
    NSInteger row = [indexPath row];
    NSDictionary *lDicReview = [_arrayReview objectAtIndex:row];
    NSString *lStrStar = [lDicReview objectForKey:KSTAR];
    for (int i=0; i<5; i++) {
        UIImageView *lImageView = [lCell.arrayStar objectAtIndex:i];
        if (i<[lStrStar intValue]) {
            [lImageView setImage:[UIImage imageNamed:@"star_light.png"]];
        } else {
            [lImageView setImage:[UIImage imageNamed:@"star.png"]];
        }
    }
    [lCell.labelDetail setText:[lDicReview objectForKey:KDETAIL]];
    [lCell.labelDate setText:[lDicReview objectForKey:KDATE]];
    [lCell.labelName setText:[lDicReview objectForKey:KNAME]];
    
    return lCell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)buttonBuyClick:(UIButton *)sender{
    NSLog(@"buy");
}

- (void)buttonAddToCarClick:(UIButton *)sender{
    NSLog(@"AddToCar");
}

- (void)buttonDismissClick:(UIButton *)sender{
    [_webViewIntroduction removeFromSuperview];
}

@end
