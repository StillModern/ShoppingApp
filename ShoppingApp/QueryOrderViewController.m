//
//  QueryOrderViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "QueryOrderViewController.h"
#import "QuerryOrderOtherViewCell.h"
#import "QuerryGoodsViewController.h"

@interface QueryOrderViewController ()

@end

@implementation QueryOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的订单";
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    

    
    _tableView = [[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped]autorelease];
    UIView *lView=[[[UIView alloc]initWithFrame:_tableView.bounds]autorelease];
    [lView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:lView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tabBarClick:)];
    
}

-(void)tabBarClick:(UIBarButtonItem *)sender{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURlChangePassword = [NSURL URLWithString:lNetConnect.lGetOrder];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURlChangePassword];
    NSString *lString = [NSString stringWithFormat:@"customerid=3"];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                [_dictionary setDictionary:lDictionary];
                
                 [_tableView reloadData];
            });
        }else{
            
            UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"取消" delegate:self cancelButtonTitle:@"信息获取失败" otherButtonTitles: nil];
            [lAlertView show];
            [lAlertView release];
        }
        
    }];
    
   
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSDictionary *lDic  = [_dictionary objectForKey:@"msg"];
    NSArray *lArray = [lDic objectForKey:@"info"];
    return lArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"Cell";
    QuerryOrderOtherViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (lCell == nil ) {
        lCell = [[[QuerryOrderOtherViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellID]autorelease];
        lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    lCell.backgroundColor = [UIColor clearColor];
    NSInteger section = [indexPath section];
    NSDictionary *lDic1 = [_dictionary objectForKey:@"msg"];
    NSArray *lArray = [lDic1 objectForKey:@"info"];
    NSDictionary *lDic = [lArray objectAtIndex:section];
    
    lCell.ordercodeLabel.text = [lDic objectForKey:@"ordercode"];
    lCell.telephoneLabel.text = [lDic objectForKey:@"telephone"];
    lCell.addressLabel.text = [lDic objectForKey:@"address"];
    lCell.nameLabel.text = [lDic objectForKey:@"name"];
    lCell.dateLabel.text = [lDic objectForKey:@"date"];
    lCell.codeLabel.text = [lDic objectForKey:@"code"];
    lCell.amountLabel.text = [lDic objectForKey:@"amount"];
    NSString *lStr = [lDic objectForKey:@"state"];
    if ([lStr intValue] == 0) {
        lCell.stateLabel.text = @"交易成功";
    }else{
        lCell.stateLabel.text = @"交易失败";
    }
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    NSDictionary *lDic1 = [_dictionary objectForKey:@"msg"];
    NSArray *lArray = [lDic1 objectForKey:@"info"];
    NSDictionary *lDic = [lArray objectAtIndex:section];
    
    QuerryGoodsViewController *lQuerryGoodsViewController = [[[QuerryGoodsViewController alloc]init]autorelease];
    [lQuerryGoodsViewController.dictionary removeAllObjects];
    [lQuerryGoodsViewController.dictionary setDictionary:lDic];
    [self.navigationController pushViewController:lQuerryGoodsViewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_dictionary release];
    [super dealloc];
}

@end
