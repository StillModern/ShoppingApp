//
//  QuerryGoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "QuerryGoodsViewController.h"
#import "AppraiseGoodsViewController.h"
#define GetImage @"http://192.168.1.141/shop/goodsimage/%@"
//#define KConnectIP @"192.168.1.141"

@interface QuerryGoodsViewController ()

@end

@implementation QuerryGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"已购商品";
        _dictionary = [[NSMutableDictionary alloc]init];
        _goodsArray = [[NSMutableArray alloc]init];
        _array = [[NSMutableArray alloc]init];
//        _goodsDictionary = [[NSMutableDictionary alloc]init];
       
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

//    NSLog(@"%i,%@",_goodsArray.count,_goodsArray);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(tabBarClick:)];
    
}

-(void)tabBarClick:(UIBarButtonItem *)sender{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



//-(void)viewWillAppear:(BOOL)animated{
//
//    [super viewWillAppear:animated];

//    NSURL *lURl = [NSURL URLWithString:GetImage];
//    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURl];
//    NSString *lString = [NSString stringWithFormat:@"customerid=3"];
//    [lRequest setHTTPMethod:@"post"];
//    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
//    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
//        if (lError == nil) {
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                
//                NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
//                [_dictionary setDictionary:lDictionary];
//                
//                [_tableView reloadData];
//            });
//        }else{
//            
//            UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"取消" delegate:self cancelButtonTitle:@"信息获取失败" otherButtonTitles: nil];
//            [lAlertView show];
//            [lAlertView release];
//        }
//        
//    }];
    
    
//    
//}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    

    if (self.isPush == YES) {
        
        for (int i = 0; i < _goodsArray.count; i++) {
            
            NSDictionary *lDic = [_goodsArray objectAtIndex:i];
            NSArray *lArray = [lDic objectForKey:@"carts"];
            [_array addObjectsFromArray:lArray];
        }
         return _array.count;
        
    }else{
    
    NSArray *lArray = [_dictionary objectForKey:@"carts"];
    return lArray.count;
        
    }
//    return _goodsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"Cell";
    QueryGoodsViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (lCell == nil ) {
        lCell = [[[QueryGoodsViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellID]autorelease];
        lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
//    NSInteger section = [indexPath section];
//    NSDictionary *lDic1 = [_dictionary objectForKey:@"msg"];
//    NSArray *lArray1 = [lDic1 objectForKey:@"info"];
//    NSDictionary *lDic2 = [lArray1 objectAtIndex:0];
//    NSArray *lArray = [lDic2 objectForKey:@"carts"];
//    NSDictionary *lDic = [lArray objectAtIndex:section];
    if (self.isPush == YES) {
        NSInteger section = [indexPath section];
        NSDictionary *lDic = [_array objectAtIndex:section];
        
        NSString *lStr = [lDic objectForKey:@"headerimage"];
        NSURL *lURl = [NSURL URLWithString:[NSString stringWithFormat:GetImage,lStr]];
        NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURl];
        NSOperationQueue *lOperationQueue = [[[NSOperationQueue alloc]init]autorelease];
        [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
            if (lError == nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIImageView *imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Flower.jpg"]]autorelease];
                    lCell.orderimageView.image = imageView.image;
                    lCell.orderimageView.image = [UIImage imageWithData:lData];
                    
                });
            }else{
                
                UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"取消" delegate:self cancelButtonTitle:@"图片获取失败" otherButtonTitles: nil];
                [lAlertView show];
                [lAlertView release];
            }
            
        }];
        
        lCell.nameLabel.text = [lDic objectForKey:@"name"];
        lCell.priceLabel.text = [lDic objectForKey:@"price"];
        lCell.amonutLabel.text = [lDic objectForKey:@"amount"];
        lCell.sizeLabel.text = [lDic objectForKey:@"size"];
        lCell.colorLabel.text = [lDic objectForKey:@"color"];
        lCell.goodscountLabel.text = [lDic objectForKey:@"goodscount"];
        
        return lCell;

        
    }else{
        
        NSInteger section = [indexPath section];
        NSArray *lArray = [_dictionary objectForKey:@"carts"];
        NSDictionary *lDic = [lArray objectAtIndex:section];
        
        NSString *lStr = [lDic objectForKey:@"headerimage"];
        NSURL *lURl = [NSURL URLWithString:[NSString stringWithFormat:GetImage,lStr]];
        NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURl];
        NSOperationQueue *lOperationQueue = [[[NSOperationQueue alloc]init]autorelease];
        [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
            if (lError == nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIImageView *imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Flower.jpg"]]autorelease];
                    lCell.orderimageView.image = imageView.image;
                    lCell.orderimageView.image = [UIImage imageWithData:lData];
                    
                });
            }else{
                
                UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"取消" delegate:self cancelButtonTitle:@"图片获取失败" otherButtonTitles: nil];
                [lAlertView show];
                [lAlertView release];
            }
            
        }];
        
        //    UIView *lView = [[UIView alloc]init];
        //    UIImageView *lImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Moon.jpg"]];
        //    [lView addSubview:lImageView];
        //    lCell.backgroundView = lView;
        
        lCell.nameLabel.text = [lDic objectForKey:@"name"];
        lCell.priceLabel.text = [lDic objectForKey:@"price"];
        lCell.amonutLabel.text = [lDic objectForKey:@"amount"];
        lCell.sizeLabel.text = [lDic objectForKey:@"size"];
        lCell.colorLabel.text = [lDic objectForKey:@"color"];
        lCell.goodscountLabel.text = [lDic objectForKey:@"goodscount"];
        
        return lCell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AppraiseGoodsViewController *lAppraiseGoodsViewController = [[[AppraiseGoodsViewController alloc]init]autorelease];
    [lAppraiseGoodsViewController.dictionary removeAllObjects];
    
    if (self.isPush == YES) {
        
        NSInteger section = [indexPath section];
        NSDictionary *lDic = [_array objectAtIndex:section];
        [lAppraiseGoodsViewController.dictionary setDictionary:lDic];
        
    }else{
        NSInteger section = [indexPath section];
        NSArray *lArray = [_dictionary objectForKey:@"carts"];
        NSDictionary *lDic = [lArray objectAtIndex:section];
        [lAppraiseGoodsViewController.dictionary setDictionary:lDic];
    }
    [self.navigationController pushViewController:lAppraiseGoodsViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_array release];
    [_goodsArray release];
    [_dictionary release];
    [super dealloc];
}

@end
