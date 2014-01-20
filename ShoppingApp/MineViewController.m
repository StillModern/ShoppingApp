//
//  MineViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "MineViewController.h"
#import "ChangePasswordViewController.h"
#import "AddressViewController.h"
#import "QueryOrderViewController.h"
#import "QuerryGoodsViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.tabBarItem.title = @"我";
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_mine"];
        
        _orderArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 30)]autorelease];
    label.text = @"StillMondern";
//    label.textColor = [UIColor redColor];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label];
    
    _tableView = [[[UITableView alloc]initWithFrame:CGRectMake(10, 60, 300, 280) style:UITableViewStyleGrouped]autorelease];
    UIView *lView=[[[UIView alloc]initWithFrame:_tableView.bounds]autorelease];
    [lView setBackgroundColor:[UIColor clearColor]];
//    _tableView.layer.cornerRadius = 10;
//    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setBackgroundView:lView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    NSString *lString1 = @"修改密码";
    NSString *lString2 = @"我的收货地址";
    NSString *lString3 = @"我的订单";
    NSString *lString4 = @"评价商品";
    
    _array = [[NSArray alloc]initWithObjects:lString1,lString2,lString3,lString4,nil];
    
    
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
//                NSLog(@"lDictionary%@",lDictionary);
                NSDictionary *lDic1 = [lDictionary objectForKey:@"msg"];
                NSArray *lArray = [lDic1 objectForKey:@"info"];
                [_orderArray setArray:lArray];
//                NSLog(@"_orderArray%@",_orderArray);
            });
        }        
    }];

}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID]autorelease];
        lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSInteger section = [indexPath section];
    lCell.textLabel.text = [_array objectAtIndex:section];
    lCell.backgroundColor = [UIColor grayColor];
    return lCell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
//    NSInteger row=[indexPath row];
    switch (section) {
        case 0:{
            ChangePasswordViewController *lChangePasswordViewController=[[[ChangePasswordViewController alloc]init]autorelease];
            UINavigationController *lNavigationController = [[[UINavigationController alloc]initWithRootViewController:lChangePasswordViewController]autorelease];
            [self.tabBarController presentViewController:lNavigationController animated:YES completion:nil];
//            [self.tabBarController pushViewController:lChangePasswordViewController animated:YES];
        }
            break;
        case 1:{
            AddressViewController *lAddressViewController=[[[AddressViewController alloc] init]autorelease];
            UINavigationController *lNavigationController = [[[UINavigationController alloc]initWithRootViewController:lAddressViewController]autorelease];
            [self.tabBarController presentViewController:lNavigationController animated:YES completion:nil];
        }
            break;
        case 2:{
            QueryOrderViewController *lQueryOrderViewController=[[[QueryOrderViewController alloc]init]autorelease];
            UINavigationController *lNavigationController = [[[UINavigationController alloc]initWithRootViewController:lQueryOrderViewController]autorelease];
            [self.tabBarController presentViewController:lNavigationController animated:YES completion:nil];
        }
            break;
        case 3:{
            QuerryGoodsViewController *lQuerryGoodsViewController=[[[QuerryGoodsViewController alloc]init]autorelease];
            [lQuerryGoodsViewController.goodsArray removeAllObjects];
            [lQuerryGoodsViewController.goodsArray setArray:_orderArray];
            lQuerryGoodsViewController.isPush = YES;
            UINavigationController *lNavigationController = [[[UINavigationController alloc]initWithRootViewController:lQuerryGoodsViewController]autorelease];
            [self.tabBarController presentViewController:lNavigationController animated:YES completion:nil];
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_orderArray release];
    [_array release];
    [super dealloc];
}

@end
