//
//  ShoppingCarViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "ShoppingCarViewController.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"购物车";
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_car.png"];
        
        _netConnect = [[NetConnect alloc]init];
        _operationQueue = [[NSOperationQueue alloc]init];
        _arrayShoppingCar = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor magentaColor];
    
    UILabel *lLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 105, 25)];
    [lLabel1 setText:@"我的购物车"];
    [lLabel1 setTextColor:[UIColor blueColor]];
    [lLabel1 setTextAlignment:NSTextAlignmentCenter];
    [lLabel1 setFont:[UIFont boldSystemFontOfSize:20]];
    [lLabel1 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lLabel1];
    [lLabel1 release];
    
    UILabel *lLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(125, 10, 85, 25)];
    [lLabel2 setText:@"全部商品"];
    [lLabel2 setTextColor:[UIColor blueColor]];
    [lLabel2 setTextAlignment:NSTextAlignmentCenter];
    [lLabel2 setFont:[UIFont boldSystemFontOfSize:20]];
    [lLabel2 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lLabel2];
    [lLabel2 release];
    
    _labelCount = [[UILabel alloc]initWithFrame:CGRectMake(210, 10, 40, 25)];
    [_labelCount setText:@""];
    [_labelCount setTextColor:[UIColor redColor]];
    [_labelCount setTextAlignment:NSTextAlignmentLeft];
    [_labelCount setFont:[UIFont boldSystemFontOfSize:20]];
    [_labelCount setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelCount];
    
    _buttonBuy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonBuy setFrame:CGRectMake(275, 10, 25, 25)];
    [_buttonBuy setHidden:YES];
    [_buttonBuy setImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    [_buttonBuy addTarget:self action:@selector(buttonBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonBuy];
    
    _viewEmpty = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, self.view.frame.size.height-45)];
    [_viewEmpty setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:_viewEmpty];
    
    UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 280, 280)];
    [lImageView setImage:[UIImage imageNamed:@"empty.png"]];
    [_viewEmpty addSubview:lImageView];
    [lImageView release];
    
    UILabel *lLabelEmpty = [[UILabel alloc]initWithFrame:CGRectMake(15, 320, 290, 25)];
    [lLabelEmpty setText:@"你的购物车是空的,赶快去购物吧"];
    [lLabelEmpty setTextColor:[UIColor blueColor]];
    [lLabelEmpty setTextAlignment:NSTextAlignmentCenter];
    [lLabelEmpty setFont:[UIFont boldSystemFontOfSize:20]];
    [lLabelEmpty setBackgroundColor:[UIColor clearColor]];
    [_viewEmpty addSubview:lLabelEmpty];
    [lLabelEmpty release];
    
    UIButton *lButtonGoToBuy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButtonGoToBuy setFrame:CGRectMake(60, 360, 200, 40)];
    [lButtonGoToBuy setTitle:@"去购物" forState:UIControlStateNormal];
    [lButtonGoToBuy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [lButtonGoToBuy.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [lButtonGoToBuy addTarget:self action:@selector(buttonGoToBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewEmpty addSubview:lButtonGoToBuy];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSURL *lURLGetCar = [NSURL URLWithString:_netConnect.lGetShoppingCar];
    NSMutableURLRequest *lRequestGetCar = [NSMutableURLRequest requestWithURL:lURLGetCar];
    NSString *lStringBody = [NSString stringWithFormat:@"customerid=%@",[ShoppingManager shareShoppingManager].coustomerid];
    [lRequestGetCar setHTTPMethod:KHTTPMETHOD];
    [lRequestGetCar setHTTPBody:[lStringBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:lRequestGetCar queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDicAllCars = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSString *lStrError = [lDicAllCars objectForKey:KERROR];
                if ([lStrError intValue] == 0) {
                    NSDictionary *lDicMsg = [lDicAllCars objectForKey:KMSG];
                    NSString *lStrCount = [lDicMsg objectForKey:KCount];
                    if ([lStrCount intValue] != 0) {
                        [_arrayShoppingCar removeAllObjects];
                        [_arrayShoppingCar addObjectsFromArray:[lDicMsg objectForKey:KINFO]];
                        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_netConnect release];
    [_operationQueue release];
    [_arrayShoppingCar release];
    [_labelCount release];
    [_viewEmpty release];
    [super dealloc];
}

- (void)buttonBuyClick:(UIButton *)sender{
    
}

- (void)buttonGoToBuyClick:(UIButton *)sender{
    [self.tabBarController setSelectedViewController:[self.tabBarController.viewControllers objectAtIndex:0]];
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
