//
//  PlaceOrderViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "GoodsOrdermessge.h"
#import "AddressViewController.h"

@interface PlaceOrderViewController ()

@end

@implementation PlaceOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 20)]autorelease];
    label.text = @"订单确认:";
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:label];
    
    UIButton *lButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton1 setFrame:CGRectMake(20, 50, 280, 55)];
    [lButton1 setBackgroundColor:[UIColor brownColor]];
    [lButton1 addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(5, 3, 270, 20)]autorelease];
//    UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(5, 25, 270, 20)]autorelease];
//    label2.text = @"姓名：%@";
//    label3.text = @"地址：%@";
//    [label2 setFont:[UIFont systemFontOfSize:10]];
//    [label2 setBackgroundColor:[UIColor clearColor]];
//    [label3 setFont:[UIFont systemFontOfSize:10]];
//    [label3 setBackgroundColor:[UIColor clearColor]];
//    [lButton1 addSubview:label2];
//    [lButton1 addSubview:label3];
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(12, 5, 30, 20)]autorelease];
    UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 30, 20)]autorelease];
    UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(12, 28, 30, 20)]autorelease];
    UILabel *label4 = [[[UILabel alloc]initWithFrame:CGRectMake(90, 28, 30, 20)]autorelease];
    label1.text = @"姓名:";
    label2.text = @"电话:";
    label3.text = @"邮编:";
    label4.text = @"地址:";
    label1.font = [UIFont systemFontOfSize:10];
    label2.font = [UIFont systemFontOfSize:10];
    label3.font = [UIFont systemFontOfSize:10];
    label4.font = [UIFont systemFontOfSize:10];
    label1.backgroundColor = [UIColor clearColor];
    label2.backgroundColor = [UIColor clearColor];
    label3.backgroundColor = [UIColor clearColor];
    label4.backgroundColor = [UIColor clearColor];
    [lButton1 addSubview:label1];
    [lButton1 addSubview:label2];
    [lButton1 addSubview:label3];
    [lButton1 addSubview:label4];
    
    _nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(38, 5, 50, 20)]autorelease];
    _telphoneLabel = [[[UILabel alloc]initWithFrame:CGRectMake(115, 5, 150, 20)]autorelease];
    _codeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(38, 28, 50, 20)]autorelease];
    _addressLabel = [[[UILabel alloc]initWithFrame:CGRectMake(115, 20, 150, 35)]autorelease];
    _addressLabel.numberOfLines = 2;
    [lButton1 addSubview:_nameLabel];
    [lButton1 addSubview:_telphoneLabel];
    [lButton1 addSubview:_codeLabel];
    [lButton1 addSubview:_addressLabel];
    [self.view addSubview:lButton1];
    
    _scrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, 320, 380)]autorelease];
    _scrollView.delegate = self;
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_scrollView];
    
    UILabel *label5 = [[[UILabel alloc]initWithFrame:CGRectMake(180, 485, 140, 20)]autorelease];
    label5.text = @"实付款：1555.00";
    label5.textColor = [UIColor blueColor];
    [label5 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label5];
    
    UIButton *lButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton2 setFrame:CGRectMake(0, 518, 320, 30)];
    [lButton2 setTitle:@"确定" forState:UIControlStateNormal];
    [lButton2 addTarget:self action:@selector(referButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButton2];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURlChangeAddress = [NSURL URLWithString:lNetConnect.lAddOrder];
    NSString *lString = [NSString stringWithFormat:@"customerid=3&addressid=3&cartids[0]=3"];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURlChangeAddress];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDic = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"lDic%@",lDic);
            });
            
        }
    }];

    
}

-(void)orderButtonClick:(UIButton *)sender{
    
    NSDictionary *lDictionary = [NSDictionary dictionaryWithObject:@"buttonClick" forKey:@"even"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"post" object:self userInfo:lDictionary];
    
    AddressViewController *lAddressViewController = [[[AddressViewController alloc]init]autorelease];
//    lAddressViewController.isButtonClick = YES;
    UINavigationController *lNavigationController = [[[UINavigationController alloc]initWithRootViewController:lAddressViewController]autorelease];
    [self presentViewController:lNavigationController animated:YES completion:nil];
}

-(void)referButtonClick:(UIButton *)sender{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    GoodsOrdermessge *lGoodsOrdermessge = [[GoodsOrdermessge alloc]init];
    
    [_scrollView addSubview:lGoodsOrdermessge];
    [lGoodsOrdermessge release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
