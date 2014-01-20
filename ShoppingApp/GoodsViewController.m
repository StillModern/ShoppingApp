//
//  GoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "GoodsViewController.h"
#import "PlaceOrderViewController.h"

@interface GoodsViewController ()

@end

@implementation GoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"商品";
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_goods"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    
    PlaceOrderViewController *lPlaceOrderViewController = [[[PlaceOrderViewController alloc]init]autorelease];
    [self presentViewController:lPlaceOrderViewController animated:YES completion:nil];
}
@end
