//
//  DetailedGoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "DetailedGoodsViewController.h"

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
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollView];
    
    [self getGoodsInfo];
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
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
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
    CGPoint offset = scrollView.contentOffset;
    CGRect rect = scrollView.frame;
    [_segmentedControl setSelectedSegmentIndex:offset.x/rect.size.width];
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
