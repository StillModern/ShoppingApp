//
//  ChangeAddressViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "ChangeAddressViewController.h"

@interface ChangeAddressViewController ()

@end

@implementation ChangeAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"收货地址管理";
        _showDictionary = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
   
    UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(25, 70, 150, 25)]autorelease];
    UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(25, 125, 150, 25)]autorelease];
    UILabel *label4 = [[[UILabel alloc]initWithFrame:CGRectMake(25, 180, 150, 25)]autorelease];
    UILabel *label5 = [[[UILabel alloc]initWithFrame:CGRectMake(25, 235, 150, 25)]autorelease];
    
    self.addressTextField = [[[UITextField alloc]initWithFrame:CGRectMake(25, 95, 270, 25)]autorelease];
    self.nameTextField = [[[UITextField alloc]initWithFrame:CGRectMake(25, 150, 270, 25)]autorelease];
    self.telephoneTextField = [[[UITextField alloc]initWithFrame:CGRectMake(25, 205, 270, 25)]autorelease];
    self.codeTextField = [[[UITextField alloc]initWithFrame:CGRectMake(25, 255, 270, 25)]autorelease];
    
 
    label2.text = @"街道地址";
    label3.text = @"收货人姓名";
    label4.text = @"手机号码";
    label5.text = @"邮编";
    
  
    label2.backgroundColor = [UIColor clearColor];
    label3.backgroundColor = [UIColor clearColor];
    label4.backgroundColor = [UIColor clearColor];
    label5.backgroundColor = [UIColor clearColor];
    
    _addressTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _telephoneTextField.backgroundColor = [UIColor whiteColor];
    _codeTextField.backgroundColor = [UIColor whiteColor];
    
    
    _addressTextField.borderStyle = UIButtonTypeDetailDisclosure;
    _nameTextField.borderStyle = UIButtonTypeDetailDisclosure;
    _telephoneTextField.borderStyle = UIButtonTypeDetailDisclosure;
    _codeTextField.borderStyle = UIButtonTypeDetailDisclosure;
    
    
    _addressTextField.placeholder = @"街道地址";//背景文字
    _nameTextField.placeholder = @"收货人姓名";
    _telephoneTextField.placeholder = @"手机号码";
    _codeTextField.placeholder = @"所在地区邮政编码";
    
   
    [_addressTextField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_nameTextField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_telephoneTextField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_codeTextField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    [self.view addSubview:label4];
    [self.view addSubview:label5];
   
    [self.view addSubview:_addressTextField];
    [self.view addSubview:_nameTextField];
    [self.view addSubview:_telephoneTextField];
    [self.view addSubview:_codeTextField];
    
    UIButton *lButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *lButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lButton1.frame = CGRectMake(190, 450, 100, 30);
    lButton2.frame = CGRectMake(40, 453, 80, 25);
    [lButton1 setTitle:@"保存" forState:UIControlStateNormal];
    [lButton2 setTitle:@"删除" forState:UIControlStateNormal];
    [lButton1 addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [lButton2 addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButton1];
    if (self.isAdd==NO) {
        
        [self.view addSubview:lButton2];
    }
    
  
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    _addressTextField.text = [_showDictionary objectForKey:@"address"];
    _nameTextField.text = [_showDictionary objectForKey:@"name"];
    _telephoneTextField.text = [_showDictionary objectForKey:@"telephone"];
    _codeTextField.text = [_showDictionary objectForKey:@"code"];
    
}

-(void)saveButtonClick:(UIButton *)sender{
    
    
    if (self.isAdd == NO) {
       
        [self deleteAddress];
        [self addAddress];
        
    }else{
        
        [self addAddress];
        
    }
    
    
    
}
-(void)deleteButtonClick:(UIButton *)sender{
    
    [self deleteAddress];

}

-(void)addAddress{
    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURlChangeAddress = [NSURL URLWithString:lNetConnect.lAddAddress];
    NSString *lString = [NSString stringWithFormat:@"customerid=3&name=%@&telephone=%@&code=%@&address=%@",self.nameTextField.text,self.telephoneTextField.text,self.codeTextField.text,self.addressTextField.text];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURlChangeAddress];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDic = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"lDic1%@",lDic);
            });
            
        }
    }];
    
}

-(void)deleteAddress{
    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURlChangeAddress = [NSURL URLWithString:lNetConnect.lDeleteAddress];
    NSString *lStr = [_showDictionary objectForKey:@"addressid"];
    NSString *lString = [NSString stringWithFormat:@"addressid=%@",lStr];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURlChangeAddress];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDic = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"lDic2%@",lDic);
            });
            
        }
    }];
}

-(void)textFieldDidEndOnExit:(UITextField *)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_showDictionary release];
    [super dealloc];
}

@end
