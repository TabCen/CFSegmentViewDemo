//
//  CFSegumentCollectionViewCell.m
//  CFOCS
//
//  Created by  chenfei on 16/7/5.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "CFSegumentCollectionViewCell.h"

@implementation CFSegumentCollectionViewCell

//@synthesize contentTableView=_contentTableView;

-(void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark 初始化方法

- (instancetype)init
{
    self = [super init];
    if (self) {
//        NSLog(@"init");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSLog(@"initWithFrame");
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

#pragma mark 懒加载
//
//-(void)setContentTableView:(UITableView *)contentTableView{
//    _contentTableView=contentTableView;
//}
//
//-(UITableView *)contentTableView{
//    return _contentTableView;
//}



@end
