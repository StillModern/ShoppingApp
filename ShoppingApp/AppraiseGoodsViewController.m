//
//  AppraiseGoodsViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "AppraiseGoodsViewController.h"
#define GetImage @"http://192.168.1.141/shop/goodsimage/%@"

@interface AppraiseGoodsViewController ()

@end

@implementation AppraiseGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"添加评论";
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
    _imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)]autorelease];
    [self.view addSubview:_imageView];
    
    
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 60, 20)]autorelease];
    label1.text = @"商品名：";
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    
    
    UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(100, 60, 60, 20)]autorelease];
    label2.text = @"价   格：";
    label2.font = [UIFont systemFontOfSize:15];
    label2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(20, 110, 70, 20)]autorelease];
    label3.text = @"评论等级：";
    label3.font = [UIFont systemFontOfSize:14];
    label3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label3];
    
//    UITextView *lTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 140, 280, 150)];
    
     
//    _lTextField = [[[UITextField alloc]initWithFrame:CGRectMake(20, 140, 280, 150)]autorelease];
//    _lTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _lTextField.placeholder = @"请输入评论内容";
//    [_lTextField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.view addSubview:_lTextField];
    
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton setFrame:CGRectMake(20, 420, 280, 30)];
    [lButton setTitle:@"提交评论" forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButton];
    
    UILabel *nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(165, 10, 130, 40)]autorelease];
    nameLabel.text = [_dictionary objectForKey:@"name"];
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:10];
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameLabel];
    
    UILabel *priceLabel = [[[UILabel alloc]initWithFrame:CGRectMake(165, 60, 130, 20)]autorelease];
    priceLabel.text = [_dictionary objectForKey:@"price"];
    priceLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:priceLabel];
    
    
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(90, 105, 30, 30);
    [_button1 addTarget:self action:@selector(appraiseButtonClick1:) forControlEvents:UIControlEventTouchUpInside];
    [_button1 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
//    [button1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_button1];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.frame = CGRectMake(125, 105, 30, 30);
    [_button2 addTarget:self action:@selector(appraiseButtonClick2:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
//    [button2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_button2];
    
    _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button3.frame = CGRectMake(160, 105, 30, 30);
    [_button3 addTarget:self action:@selector(appraiseButtonClick3:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
//    [button3 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_button3];
    
    _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button4.frame = CGRectMake(195, 105, 30, 30);
    [_button4 addTarget:self action:@selector(appraiseButtonClick4:) forControlEvents:UIControlEventTouchUpInside];
    [_button4 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
//    [button4 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_button4];
    
    _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button5.frame = CGRectMake(230, 105, 30, 30);
    [_button5 addTarget:self action:@selector(appraiseButtonClick5:) forControlEvents:UIControlEventTouchUpInside];
    [_button5 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
//    [button5 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_button5];
    
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSString *lStr = [_dictionary objectForKey:@"headerimage"];
    NSURL *lURl = [NSURL URLWithString:[NSString stringWithFormat:GetImage,lStr]];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURl];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                
                UIImageView *imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Flower.jpg"]]autorelease];
                
                _imageView.image = imageView.image;
                _imageView.image = [UIImage imageWithData:lData];
                
            });
        }else{
            
            UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"取消" delegate:self cancelButtonTitle:@"图片获取失败" otherButtonTitles: nil];
            [lAlertView show];
            [lAlertView release];
        }
        
    }];
}


-(void)buttonClick:(UIButton *)sender{
    
    int i;
//    if (_isbutton5 == NO) {
//        i = 4;
//        if (_isbutton4 == NO) {
//            i = 3;
//            if (_isbutton3 == NO) {
//                i = 2;
//                if (_isbutton2 == NO) {
//                    i = 1;
//                    if (_isbutton1 == NO) {
//                        i = 0;
//                    } else {
//                        i = 1;
//                    }
//                } else {
//                    i = 2;
//                }
//            } else {
//                i = 3;
//            }
//        } else {
//            i = 4;
//        }
//    } else {
//        i = 5;
//    }
    
    if (_isbutton5) {
        i = 5;
    } else if (_isbutton4){
        i = 4;
    } else if (_isbutton3){
        i = 3;
    } else if (_isbutton2){
        i = 2;
    } else if (_isbutton1){
        i = 1;
    } else {
        i = 0;
    }
    
    
    
    NSString *lStr = [_dictionary objectForKey:@"goodsid"];
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURlChangePassword = [NSURL URLWithString:lNetConnect.lAddReview];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURlChangePassword];
    NSString *lString = [NSString stringWithFormat:@"goodsid=%@&customerid=3&star=%i&detail=%@",lStr,i,_lTextField.text];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"lDictionary%@",lDictionary);
                
            });
        }else{
            
            UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"取消" delegate:self cancelButtonTitle:@"评论提交失败" otherButtonTitles: nil];
            [lAlertView show];
            [lAlertView release];
        }
        
    }];

}

-(void)textFieldDidEndOnExit:(UITextField *)sender{
    
}

-(void)appraiseButtonClick1:(UIButton *)sender{
    _isbutton1 = !_isbutton1;
    if (!_isbutton1) {
        _isbutton2 = NO;
        _isbutton3 = NO;
        _isbutton4 = NO;
        _isbutton5 = NO;
    }
    [self setButtonImage];
//    [UIView beginAnimations:@"animation" context:nil];
//    [_button1 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [UIView commitAnimations];
}

-(void)appraiseButtonClick2:(UIButton *)sender{
    _isbutton2 = !_isbutton2;
    if (_isbutton2) {
        _isbutton1 = YES;
    } else {
        _isbutton3 = NO;
        _isbutton4 = NO;
        _isbutton5 = NO;
    }
    [self setButtonImage];
//    [UIView beginAnimations:@"animation" context:nil];
//    [_button1 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button2 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [UIView commitAnimations];
}

-(void)appraiseButtonClick3:(UIButton *)sender{
    _isbutton3 = !_isbutton3;
    if (_isbutton3) {
        _isbutton1 = YES;
        _isbutton2 = YES;
    } else {        
        _isbutton4 = NO;
        _isbutton5 = NO;
    }
    [self setButtonImage];
//    [UIView beginAnimations:@"animation" context:nil];
//    [_button1 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button2 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button3 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [UIView commitAnimations];
}

-(void)appraiseButtonClick4:(UIButton *)sender{
    _isbutton4 = !_isbutton4;
    if (_isbutton4) {
        _isbutton1 = YES;
        _isbutton2 = YES;
        _isbutton3 = YES;
    } else {        
        _isbutton5 = NO;
    }
    [self setButtonImage];
//    [UIView beginAnimations:@"animation" context:nil];
//    [_button1 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button2 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button3 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button4 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [UIView commitAnimations];
}

-(void)appraiseButtonClick5:(UIButton *)sender{
    _isbutton5 = !_isbutton5;
    if (_isbutton5) {
        _isbutton1 = YES;
        _isbutton2 = YES;
        _isbutton3 = YES;
        _isbutton4 = YES;
    } 
    [self setButtonImage];
//    [UIView beginAnimations:@"animation" context:nil];
//    [_button1 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button2 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button3 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button4 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [_button5 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [UIView commitAnimations];
}

- (void)setButtonImage{
    [UIView beginAnimations:@"animation" context:nil];
    if (_isbutton1) {
        [_button1 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    } else {
        [_button1 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    }
    
    if (_isbutton2) {
        [_button2 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    } else {
        [_button2 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    }
    
    if (_isbutton3) {
        [_button3 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    } else {
        [_button3 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    }
    
    if (_isbutton4) {
        [_button4 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    } else {
        [_button4 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    }
    
    if (_isbutton5) {
        [_button5 setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    } else {
        [_button5 setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    }
    [UIView commitAnimations];
    
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
