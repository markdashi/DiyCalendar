//
//  CalendarModel.h
//  Calendar
//
//  Created by 俊斐  王 on 2018/6/9.
//  Copyright © 2018年 俊斐  王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *dateString;

@property (nonatomic, copy) NSString *weekday;
@property (nonatomic, copy) NSString *day;
//是否选中
@property (nonatomic, assign) BOOL isSelected;
//是否有数据
@property (nonatomic, assign) BOOL isHasData;

@end
