//
//  UIView+Frame.m
//  Calendar
//
//  Created by 俊斐  王 on 2018/6/9.
//  Copyright © 2018年 俊斐  王. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (CGFloat)height{
    return self.frame.size.height;
}

@end
