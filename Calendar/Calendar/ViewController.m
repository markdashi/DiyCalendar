//
//  ViewController.m
//  Calendar
//
//  Created by 俊斐  王 on 2018/6/9.
//  Copyright © 2018年 俊斐  王. All rights reserved.
//

#import "ViewController.h"
#import "JFCalendar.h"

@interface ViewController ()<JFCalenderViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    JFCalenderView *view = [[JFCalenderView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 130)];
    view.delegate = self;
    view.backgroundColor = [UIColor lightGrayColor];
    view.hasDataDate = @[@"20180606",@"20180605",@"20180604",@"20180601",@"20180528",
                         @"20180516"];
    [self.view addSubview:view];
}
- (void)JFCalenderViewDidSelectedDate:(CalendarModel *)item{
    NSLog(@"%@",item.dateString);
}







@end
