//
//  CalendarViewCell.m
//  Calendar
//
//  Created by 俊斐  王 on 2018/6/9.
//  Copyright © 2018年 俊斐  王. All rights reserved.
//

#import "CalendarViewCell.h"
#import "CalendarModel.h"

@interface CalendarViewCell()

@property (weak, nonatomic) IBOutlet UILabel *weenDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *flagView;

@end

@implementation CalendarViewCell

- (void)setCalendarItem:(CalendarModel *)calendarItem{
    _calendarItem = calendarItem;
    self.weenDayLabel.text = calendarItem.weekday;
    self.dayLabel.text = calendarItem.day;
    if (calendarItem.isSelected) {
        self.dayLabel.backgroundColor = [UIColor redColor];
        self.dayLabel.textColor = [UIColor whiteColor];
    }else{
        self.dayLabel.backgroundColor = [UIColor clearColor];
        self.dayLabel.textColor = [UIColor blackColor];
    }
    if (calendarItem.isHasData) {
        self.flagView.hidden = NO;
        self.dayLabel.textColor = [UIColor blackColor];
        if (calendarItem.isSelected) {
            self.flagView.hidden = YES;
            self.dayLabel.textColor = [UIColor whiteColor];
        }
    }else{
        self.flagView.hidden = YES;
        self.dayLabel.textColor = [UIColor lightGrayColor];
        self.dayLabel.backgroundColor = [UIColor clearColor];
    }
}



@end
