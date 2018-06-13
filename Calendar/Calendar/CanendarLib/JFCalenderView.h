//
//  JFCalenderView.h
//  Calendar
//
//  Created by 俊斐  王 on 2018/6/9.
//  Copyright © 2018年 俊斐  王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class CalendarModel;
@protocol JFCalenderViewDelegate<NSObject>
- (void)JFCalenderViewDidSelectedDate:(CalendarModel *)item;
@end

@interface JFCalenderView : UIView

@property (nonatomic, strong) NSArray *hasDataDate;

@property (nonatomic, weak) id<JFCalenderViewDelegate> delegate;

@end
