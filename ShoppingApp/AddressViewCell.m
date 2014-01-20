//
//  AddressViewCell.m
//  ShoppingApp
//
//  Created by TY on 14-1-9.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "AddressViewCell.h"
#import "AddressViewController.h"

@implementation AddressViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        
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
        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:label3];
        [self addSubview:label4];
        
        _nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(38, 5, 50, 20)]autorelease];
        _telphoneLabel = [[[UILabel alloc]initWithFrame:CGRectMake(115, 5, 100, 20)]autorelease];
        _codeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(38, 28, 50, 20)]autorelease];
        _addressLabel = [[[UILabel alloc]initWithFrame:CGRectMake(115, 20, 150, 35)]autorelease];
        _addressLabel.numberOfLines = 2;
        [self addSubview:_nameLabel];
        [self addSubview:_telphoneLabel];
        [self addSubview:_codeLabel];
        [self addSubview:_addressLabel];
        

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationPost:) name:@"post" object:nil];
        
    }
    return self;
}

-(void)notificationPost:(NSNotification *)sender{
    
    NSDictionary *lDictionary = sender.userInfo;
    NSString *lString = [lDictionary objectForKey:@"even"];
    
    if ([lString isEqualToString:@"buttonClick"]) {
        UIButton *lButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [lButton setFrame:CGRectMake(220, 5, 30, 20)];
        lButton.backgroundColor = [UIColor redColor];
        [lButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lButton];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
