//
//  ShoppingCarViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "TableViewShoppingCarCell.h"

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
        _arrayIsCheck = [[NSMutableArray alloc]init];
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
    [_labelCount setTextColor:[UIColor blackColor]];
    [_labelCount setTextAlignment:NSTextAlignmentLeft];
    [_labelCount setFont:[UIFont boldSystemFontOfSize:20]];
    [_labelCount setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_labelCount];
    
    _buttonBuy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonBuy setFrame:CGRectMake(285, 10, 25, 25)];
    [_buttonBuy setHidden:YES];
    [_buttonBuy setBackgroundImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(320, 45, 320, self.view.frame.size.height-45) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_tableView];
    
    _viewControll = [[UIView alloc]initWithFrame:CGRectMake(0, self.tabBarController.view.frame.size.height, 320, 50)];
    [_viewControll setBackgroundColor:[UIColor magentaColor]];    
    [self.tabBarController.view addSubview:_viewControll];
    UIButton *lbuttonDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lbuttonDelete setFrame:CGRectMake(5, 5, 150, 40)];
    [lbuttonDelete setTitle:@"删除" forState:UIControlStateNormal];
    [lbuttonDelete.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [lbuttonDelete addTarget:self action:@selector(buttonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewControll addSubview:lbuttonDelete];
    
    UIButton *lButtonOrder = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButtonOrder setFrame:CGRectMake(160, 5, 155, 40)];
    [lButtonOrder setTitle:@"去结算" forState:UIControlStateNormal];
    [lButtonOrder.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [lButtonOrder addTarget:self action:@selector(buttonOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [_viewControll addSubview:lButtonOrder];
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
                        [_labelCount setText:[NSString stringWithFormat:@"%@",lStrCount]];
                        [self setShoppingCarView];
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
    [_tableView release];
    [_viewControll release];
    [_arrayIsCheck release];
    [super dealloc];
}

- (void)setShoppingCarView{
    [_buttonBuy setHidden:NO];
    [_tableView setFrame:CGRectMake(0, 45, 320, self.view.frame.size.height-45)];
    [_arrayIsCheck removeAllObjects];
    for (int i=0; i<_arrayShoppingCar.count; i++) {
        [_arrayIsCheck addObject:[NSNumber numberWithBool:NO]];
    }
    [_tableView reloadData];
}

- (void)buttonBuyClick:(UIButton *)sender{
    _isBuy = !_isBuy;
    
    if (_isBuy) {
        [_buttonBuy setBackgroundImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateNormal];
    } else {
        [_buttonBuy setBackgroundImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    }
    
    for (int i=0; i<_arrayShoppingCar.count; i++) {
        [_arrayIsCheck replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:_isBuy]];
    }
    
    [_tableView reloadData];
    [self setViewControll];
}

- (void)buttonGoToBuyClick:(UIButton *)sender{
    [self.tabBarController setSelectedViewController:[self.tabBarController.viewControllers objectAtIndex:0]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayShoppingCar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellIdentifier = KCELLIDENTIFIER;
    TableViewShoppingCarCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    if (lCell == nil) {
        lCell = [[[TableViewShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier]autorelease];
    }
    lCell.delegate = self;
    
    NSInteger row = [indexPath row];
    NSDictionary *lDicCarInfo = [_arrayShoppingCar objectAtIndex:row];
    [lCell.imageViewGood setImage:[UIImage imageNamed:@"empty.png"]];
    NSString *lImagePath = [_netConnect.lGoodsImage stringByAppendingString:[lDicCarInfo objectForKey:KIMAGE]];
    NSURL *lURL = [NSURL URLWithString:lImagePath];
    NSURLRequest *lRequest = [NSURLRequest requestWithURL:lURL];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:_operationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *lImage = [UIImage imageWithData:lData];
                [lCell.imageViewGood setImage:lImage];
            });
        }
    }];
    
    lCell.labelName.text = [lDicCarInfo objectForKey:KNAME];
    [lCell.buttonCount setTitle:[lDicCarInfo objectForKey:KGOODSCOUNT] forState:UIControlStateNormal];
    lCell.labelPrice.text = [NSString stringWithFormat:@"￥%@",[lDicCarInfo objectForKey:KPRICE]];
    lCell.labelAmount.text = [lDicCarInfo objectForKey:KAMOUNT];
    
    NSNumber *lNumber = [_arrayIsCheck objectAtIndex:row];
    if ([lNumber boolValue]) {
        [lCell.buttonCheck setBackgroundImage:[UIImage imageNamed:@"checkbox_on.png"] forState:UIControlStateNormal];
    } else {
        [lCell.buttonCheck setBackgroundImage:[UIImage imageNamed:@"checkbox_off.png"] forState:UIControlStateNormal];
    }
    
    return lCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    NSNumber *lNumber = [_arrayIsCheck objectAtIndex:row];
    [_arrayIsCheck replaceObjectAtIndex:row withObject:[NSNumber numberWithBool:![lNumber boolValue]]];
    [tableView reloadData];    
    [self setViewControll];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)buttonCheckClick:(TableViewShoppingCarCell *)shoppingCarCell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:shoppingCarCell];
    NSInteger row = [indexPath row];
    NSNumber *lNumber = [_arrayIsCheck objectAtIndex:row];
    [_arrayIsCheck replaceObjectAtIndex:row withObject:[NSNumber numberWithBool:![lNumber boolValue]]];    
    [_tableView reloadData];
    [self setViewControll];
}

- (void)buttonCountClick{
    NSLog(@"count");
}

- (void)setViewControll{
    if ([_arrayIsCheck containsObject:[NSNumber numberWithBool:YES]]) {
        [_viewControll setFrame:CGRectMake(0, self.tabBarController.view.frame.size.height-50, 320, 50)];
    } else {
        [_viewControll setFrame:CGRectMake(0, self.tabBarController.view.frame.size.height, 320, 50)];
    }
}

- (void)buttonDeleteClick:(UIButton *)sender{
    NSLog(@"delete");
}

- (void)buttonOrderClick:(UIButton *)sender{
    NSLog(@"order");
}

- (void)addCountView{
    
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
