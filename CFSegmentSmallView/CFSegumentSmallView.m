//
//  CFSegumentSmallView.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2017/5/9.
//  Copyright © 2017年 chenfei. All rights reserved.
//

#import "CFSegumentSmallView.h"

#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height


#define CF_COLOR(R,G,B)  [UIColor colorWithRed:R green:G blue:B alpha:1]
#define CF_COLOR_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColor_Tittle_Selected CF_COLOR_RGB(0xEB3434)
#define kColor_Tittle_Bar CF_COLOR_RGB(0xFFFFFF)
#define kColor_Tittle CF_COLOR_RGB(0x333333)

@interface CFSegumentSmallView ()

@property(nonatomic,assign)NSInteger tittlesNum;

//@property(nonatomic,strong)UIView   *tittleView;

@end

@implementation CFSegumentSmallView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 创建子试图

-(void)buildTittleView{
    
    CGFloat w = kSelfWidth;
    CGFloat h = 45;
    
    //将tittleNum小于等于的滚动情况------暂时
    
    for (int i=0; i<self.tittlesNum; ++i) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i*w/_tittlesNum, 0, w/_tittlesNum, h)];
        
        [button setBackgroundColor:kColor_Tittle_Bar];
        [button setTitle:_tittles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:kColor_Tittle forState:UIControlStateNormal];
        [button setTitleColor:kColor_Tittle_Selected forState:UIControlStateHighlighted];
        
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        
        button.tag=200+i;
        [button addTarget:self action:@selector(tittleButtonSellect:) forControlEvents:UIControlEventTouchUpInside];

        button.userInteractionEnabled = YES;
        [self addSubview:button];
    }
}

#pragma mark - 私有方法

-(void)tittleButtonSellect:(id)sender{
    UIView * view = [[self.subVCs[0] class].new view];
    
    [self.superview addSubview:view];
}


#pragma mark - set\get方法

-(void)setTittles:(NSArray<NSString *> *)tittles{
    _tittles = tittles;
    self.tittlesNum = tittles.count;
    [self buildTittleView];
}

-(void)setSubVCs:(NSArray<Class> *)subVCs{
    _subVCs = subVCs;
}


@end
