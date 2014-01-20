//
//  AddressViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "AddressViewController.h"
#import "ChangeAddressViewController.h"
#import "AddressViewCell.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _data = [[NSMutableData alloc]init];
        _array = [[NSArray alloc]init];
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    _tableView = [[[UITableView alloc]initWithFrame:CGRectMake(20, 20, 280, 400) style:UITableViewStyleGrouped]autorelease];
    UIView *lView=[[[UIView alloc]initWithFrame:_tableView.bounds]autorelease];
    [lView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:lView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton setFrame:CGRectMake(25, 450, 270, 30)];
    [lButton setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButton];
    
    

    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURL = [NSURL URLWithString:lNetConnect.lGetAddress];
    NSString *lString = @"customerid=3";
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection = [NSURLConnection connectionWithRequest:lRequest delegate:self];
    [lConnection start];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(tabBarClick:)];
    
}

-(void)tabBarClick:(UIBarButtonItem *)sender{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURL = [NSURL URLWithString:lNetConnect.lGetAddress];
    NSString *lString = @"customerid=3";
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection = [NSURLConnection connectionWithRequest:lRequest delegate:self];
    [lConnection start];
    
//    [_tableView reloadData];
}

-(void)buttonClick:(UIButton *)sender{
    
  
    ChangeAddressViewController *lChangeAddressViewController = [[[ChangeAddressViewController alloc]init]autorelease];
    lChangeAddressViewController.isAdd=YES;
    [self.navigationController pushViewController:lChangeAddressViewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [_data setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSDictionary *lDic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    [_dictionary setDictionary:lDic];
    [_tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    NSDictionary *lDictionary = [_dictionary objectForKey:@"msg"];
    NSArray *lArray=[lDictionary objectForKey:@"info"];
    return lArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"Cell";
    AddressViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (lCell == nil ) {
        lCell = [[[AddressViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellID]autorelease];
        lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSInteger section = [indexPath section];
    NSDictionary *lDic1 = [_dictionary objectForKey:@"msg"];
    NSArray *lArray = [lDic1 objectForKey:@"info"];
    NSDictionary *lDic = [lArray objectAtIndex:section];
    lCell.nameLabel.text = [lDic objectForKey:@"name"];
    lCell.telphoneLabel.text = [lDic objectForKey:@"telephone"];
    lCell.codeLabel.text = [lDic objectForKey:@"code"];
    lCell.addressLabel.text = [lDic objectForKey:@"address"];
    lCell.nameLabel.font = [UIFont systemFontOfSize:10];
    lCell.telphoneLabel.font = [UIFont systemFontOfSize:10];
    lCell.codeLabel.font = [UIFont systemFontOfSize:10];
    lCell.addressLabel.font = [UIFont systemFontOfSize:10];
    return lCell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    NSDictionary *lDic1 = [_dictionary objectForKey:@"msg"];
    NSArray *lArray = [lDic1 objectForKey:@"info"];
    NSDictionary *lDic = [lArray objectAtIndex:section];
    
    ChangeAddressViewController *lChangeAddressViewController = [[[ChangeAddressViewController alloc]init]autorelease];
    [lChangeAddressViewController.showDictionary removeAllObjects];
    [lChangeAddressViewController.showDictionary setDictionary:lDic];
    
   
    [self.navigationController pushViewController:lChangeAddressViewController animated:YES];
}

- (void)dealloc
{
    [_data release];
    [_array release];
    [_dictionary release];
    [super dealloc];
}

@end
