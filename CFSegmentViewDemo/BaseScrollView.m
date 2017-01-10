//
//  BaseScrollView.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/12/26.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"开始启动%f",self.contentOffset.y);
}


@end
