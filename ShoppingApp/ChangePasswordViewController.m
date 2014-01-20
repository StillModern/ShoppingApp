//
//  ChangePasswordViewController.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

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
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel *label1 = [[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 30)]autorelease];
    label1.text = @"用户名：";
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 60, 30)]autorelease];
    label2.text = @"旧密码：";
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[[UILabel alloc]initWithFrame:CGRectMake(20, 120, 60, 30)]autorelease];
    label3.text = @"新密码：";
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label3];
    
    _nameTextField = [[[UITextField alloc]initWithFrame:CGRectMake(80, 20, 200, 30)]autorelease];
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.borderStyle = UIControlContentVerticalAlignmentFill;
    _nameTextField.placeholder = @"请输入用户名";
    [_nameTextField addTarget:self action:@selector(TextFieldchange:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_nameTextField];
    
    _oldPassword = [[[UITextField alloc]initWithFrame:CGRectMake(80, 70, 200, 30)]autorelease];
    _oldPassword.backgroundColor = [UIColor whiteColor];
    _oldPassword.borderStyle = UIControlContentVerticalAlignmentFill;
    _oldPassword.placeholder = @"请输入旧密码";
    [_oldPassword addTarget:self action:@selector(TextFieldchange:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_oldPassword];
    
    _newPassword = [[[UITextField alloc]initWithFrame:CGRectMake(80, 120, 200, 30)]autorelease];
    _newPassword.backgroundColor = [UIColor whiteColor];
    _newPassword.borderStyle = UIControlContentVerticalAlignmentFill;
    _newPassword.placeholder = @"请输入新密码";
    [_newPassword addTarget:self action:@selector(TextFieldchange:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_newPassword];
    
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton setFrame:CGRectMake(15, 170, 290, 30)];
    [lButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tabBarClick:)];
    
}

-(void)tabBarClick:(UIBarButtonItem *)sender{
    

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)buttonClick:(UIButton *)sender{
    
    NetConnect *lNetConnect = [[[NetConnect alloc]init]autorelease];
    NSURL *lURlChangePassword = [NSURL URLWithString:lNetConnect.lChangePassword];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURlChangePassword];
    NSString *lString = [NSString stringWithFormat:@"name=%@&oldpassword=%@&newpassword=%@",_nameTextField.text,_oldPassword.text,_newPassword.text];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[lString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *lOperationQueue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:lRequest queue:lOperationQueue completionHandler:^(NSURLResponse *lResponse, NSData *lData, NSError *lError) {
        if (lError == 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *lDic = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
//                NSLog(@"%@",lDic);
                NSString *lString = [lDic objectForKey:@"error"];
                if (lString != 0) {
                    UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"返回" delegate:self cancelButtonTitle:@"旧密码错误，请重新输入" otherButtonTitles:nil];
                    [lAlertView show];
                    [lAlertView release];
                }else{
                    LoginViewController *lLoginViewController = [[[LoginViewController alloc]init]autorelease];
                    [self.navigationController pushViewController:lLoginViewController animated:YES];
                    
                }
                
            });
        }
    }];
    
    
    LoginViewController *lLoginViewController = [[[LoginViewController alloc]init]autorelease];
//    UINavigationController *lNavigationController = [[UINavigationController alloc]initWithRootViewController:lLoginViewController];
    [self.navigationController pushViewController:lLoginViewController animated:YES];
}

-(void)TextFieldchange:(UITextField *)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
