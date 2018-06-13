//
//  JFCalenderView.m
//  Calendar
//
//  Created by 俊斐  王 on 2018/6/9.
//  Copyright © 2018年 俊斐  王. All rights reserved.
//

#import "JFCalenderView.h"
#import "UIView+Frame.h"
#import "CalendarViewCell.h"
#import "CalendarModel.h"

@interface JFCalenderView()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UICollectionView *calenderView;
@property (nonatomic, strong) UILabel *dateTitle;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *weekDay;

@property (nonatomic, strong) NSDictionary *months;

@property (nonatomic, strong) NSCalendar *calendar;
@end

@implementation JFCalenderView

#pragma mark - lazy
- (NSArray *)weekDay{
    if (!_weekDay) {
        _weekDay = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    }
    return _weekDay;
}
- (NSDictionary *)months{
    if (!_months) {
        _months = [NSDictionary dictionaryWithObjectsAndKeys:@"January",@"1",
                                         @"February ",@"2",
                   @"March",@"3",
                   @"April",@"4",
                   @"May",@"5",
                   @"June",@"6",
                   @"July",@"7",
                   @"August",@"8",
                   @"September",@"9",
                   @"October",@"10",
                   @"November",@"11",
                   @"December",@"12",
                   nil];
    }
    return _months;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:35];
        for (NSInteger i=34; i>=0; i--) {
            //1.获取星期
            CalendarModel *calendar = [[CalendarModel alloc] init];
            calendar.weekday = [self weekFromIndex:(int)i];
            //2.获取日期天
            calendar.day = [self dayFromIndex:(int)i];
            //3.具体的日期 20170831
            calendar.dateString = [self realFormatterDateFromIndex:(int)i];
            [_dataSource addObject:calendar];
        }
    }
    return _dataSource;
}


- (NSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_calendar setTimeZone:[NSTimeZone localTimeZone]];
    }
    return _calendar;
}

static NSInteger dayOfCount = 7;
static CGFloat marginTop = 30;
- (instancetype)init{
    if (self == [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    
    self.dateTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, marginTop)];
    self.dateTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateTitle];
    self.dateTitle.text = [self dateFormatterFromString:[self getCurrentDayString]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.width/dayOfCount, self.height-marginTop);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.calenderView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, marginTop,self.width, self.height-marginTop) collectionViewLayout:layout];
    self.calenderView.backgroundColor = [UIColor whiteColor];
    self.calenderView.pagingEnabled = YES;
    self.calenderView.showsHorizontalScrollIndicator = false;
    self.calenderView.bounces = NO;
    self.calenderView.delegate = self;
    self.calenderView.dataSource = self;
    [self addSubview:self.calenderView];
    self.calenderView.contentOffset = CGPointMake(5*self.width, 0);
    [self.calenderView registerNib:[UINib nibWithNibName:@"CalendarViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"canderItemcell"];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"canderItemcell" forIndexPath:indexPath];
    cell.calendarItem = self.dataSource[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarModel *item = self.dataSource[indexPath.row];
    if (!item.isHasData) return;
    for (CalendarModel *model in self.dataSource) {
                if (model.dateString == item.dateString) {
                    model.isSelected = YES;
                }else{
                    model.isSelected = NO;
                }
            }
    [collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(JFCalenderViewDidSelectedDate:)]) {
        [_delegate JFCalenderViewDidSelectedDate:item];
    }
}

//设置数据
- (void)setHasDataDate:(NSArray *)hasDataDate{
    
    int index = 0;
    for (NSString *date in hasDataDate) {
        for (CalendarModel *item in self.dataSource) {
            if ([date isEqualToString:item.dateString]) {
                item.isHasData = YES;
                if (index==0) {
                    item.isSelected = YES;
                }
                break;
            }
        }
        index++;
    }
    [self.calenderView reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = floor(scrollView.contentOffset.x/375);
    CalendarModel *item = self.dataSource[(index+1)*dayOfCount-1];
    self.dateTitle.text = [self dateFormatterFromString:item.dateString];
}


#pragma mark - private
- (NSString *)weekFromIndex:(int)index{
    NSDate *date = [NSDate date];
    NSDate *theDate = [date initWithTimeIntervalSinceNow:-index*24*60*60];
    NSDateComponents *comp = [self.calendar components:NSCalendarUnitWeekday fromDate:theDate];
    return self.weekDay[comp.weekday-1];
}
- (NSString *)dayFromIndex:(int)index{
    NSDate *date = [NSDate date];
    NSDate *theDate = [date initWithTimeIntervalSinceNow:-index*24*60*60];
    NSDateComponents *comp = [self.calendar components:NSCalendarUnitDay fromDate:theDate];
    return [NSString stringWithFormat:@"%02zd",comp.day];
}

- (NSString *)realFormatterDateFromIndex:(int)index{
    NSDate *date = [NSDate date];
    NSDate *theDate = [date initWithTimeIntervalSinceNow:-index*24*60*60];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *comp = [self.calendar components:unit fromDate:theDate];
    return [NSString stringWithFormat:@"%zd%02zd%02zd",comp.year,comp.month,comp.day];
}
- (NSString *)dateFormatterFromString:(NSString *)date{
    NSString *year = [date substringToIndex:4];
    NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
    month = [NSString stringWithFormat:@"%d",[month intValue]];
    return [NSString stringWithFormat:@"%@ %@",self.months[month],year];
}
- (NSString *)getCurrentDayString{
    NSDate *curDate = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *comp = [self.calendar components:unit fromDate:curDate];
    return [NSString stringWithFormat:@"%zd%02zd%02zd",comp.year,comp.month,comp.day];
}










@end
