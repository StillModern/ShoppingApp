//
//  SearchHistoryView.m
//  ShoppingApp
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "SearchHistoryView.h"

@implementation SearchHistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 60, 320, 510)];
    if (self) {
        [self setBackgroundColor:[UIColor magentaColor]];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 300) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:[UIColor cyanColor]];
        [_tableView setSeparatorColor:[UIColor blueColor]];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
        _buttonClean = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonClean setFrame:CGRectMake(20, 310, 280, 40)];
        [_buttonClean setTitle:@"清空历史记录" forState:UIControlStateNormal];
        [_buttonClean.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [_buttonClean setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_buttonClean addTarget:self action:@selector(buttonCleanClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonClean];
        
        UILabel *lLabelEmpty = [[UILabel alloc]initWithFrame:CGRectMake(50, 400, 210, 30)];
        [lLabelEmpty setText:@"有事没事向下滑动"];
        [lLabelEmpty setTextAlignment:NSTextAlignmentCenter];
        [lLabelEmpty setTextColor:[UIColor blueColor]];
        [lLabelEmpty setFont:[UIFont boldSystemFontOfSize:25]];
        [lLabelEmpty setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lLabelEmpty];
        [lLabelEmpty release];
        
        UISwipeGestureRecognizer *lSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizer:)];
        lSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:lSwipeGestureRecognizer];
        [lSwipeGestureRecognizer release];
        
        [self resetTableView];
    }
    return self;
}

- (void)dealloc{
    [_tableView release];
    [super dealloc];
}

- (void)buttonCleanClick:(UIButton *)sender{
    [[ShoppingManager shareShoppingManager].arrayHistory removeAllObjects];
    [self resetTableView];
}

- (void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)sender{
    [_deleagate swipeGestureRecognizer];
}

- (void)resetTableView{
    if ([ShoppingManager shareShoppingManager].arrayHistory.count == 0) {
        [_tableView setBounces:NO];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_buttonClean setHidden:YES];        
    } else {
        [_tableView setBounces:YES];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_buttonClean setHidden:NO];
    }
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ShoppingManager shareShoppingManager].arrayHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellIdentifier = KCELLIDENTIFIER;
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:lCellIdentifier];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lCellIdentifier]autorelease];
    }
    lCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    NSInteger row = [indexPath row];
    lCell.textLabel.text = [[ShoppingManager shareShoppingManager].arrayHistory objectAtIndex:row];
    
    return lCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    [_deleagate historySelect:[[ShoppingManager shareShoppingManager].arrayHistory objectAtIndex:row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    [_deleagate historySelect:[[ShoppingManager shareShoppingManager].arrayHistory objectAtIndex:row]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
