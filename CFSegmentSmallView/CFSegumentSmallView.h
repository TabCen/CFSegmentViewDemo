//
//  CFSegumentSmallView.h
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2017/5/9.
//  Copyright © 2017年 chenfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFSegumentSmallView : UIView


/**
 *  设置标题数组
 */
@property(nonatomic,copy) NSArray<NSString *>       *tittles;
/**
 *  标题栏所对应的类
 */
@property(nonatomic,copy) NSArray<Class>            *subVCs;

@end
