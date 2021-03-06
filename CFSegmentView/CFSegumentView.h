//
//  CFSegmentView.h
//  CFOCS
//
//  Created by  chenfei on 16/6/14.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDEFAULT_TITTLES_NUM 1              //设置默认tittles的个数
#define kDEFAULT_TABLEVIEWS_NUM 1           //设置默认tableViews的个数
#define kDEFAULT_MAX_TITTLES_NUM 6          //默认tittle最大个数，大余这个可以滚动

#define kTittleHeight 45                    //默认TittleView的高度

//#define SCROLLVIEW_or_COLLECTIONVIEW 1      //0表示scrollView、1表示CollectionView
NS_ASSUME_NONNULL_BEGIN
@class CFSegumentView;

@protocol CFSegumentViewDelegate <NSObject>
//当滑动后都会调用
//-(void)CFSegumentView:(CFSegumentView *)segumetView currentIndex:(NSString *)currentIndex;
//当滑动到TableView时调用
-(void)CFSegumentView:(CFSegumentView *)segumetView curTableVC_willDisplay:(UITableViewController *)tableVC;
//当滑动到普通控制器时调用
-(void)CFSegumentView:(CFSegumentView *)segumetView curVC_willDisplay:(UIViewController *)vc;

@end


@interface CFSegumentView : UIView
/**
 *  设置标题数组
 */
@property(nonatomic,copy) NSArray<NSString *>       *tittles;
/**
 *  标题栏所对应的类
 */
@property(nonatomic,copy) NSArray<Class>            *tableClasses;

/**
 当前控件加载在哪个控制器中，用于点击进入下一个页面
 */
@property(nonatomic,weak)UIViewController           *rootViewController;

@property(nonatomic)CGFloat                         tittleViewHeight;

@property(nonatomic,weak)id<CFSegumentViewDelegate> delegate;

@property(nonatomic)BOOL                            scrollThenRefreshing;               //当滑动后是否需要刷新

@property(nonatomic)BOOL                            showTittle;                         //default YES

@property(nonatomic)BOOL                            showTittleScrollIndicator;          //default NO

@property(nonatomic)BOOL                            tittleBig;                          //按钮选中后字体是否变大，default YES

@property(nonatomic,strong)UIView                   *tittleView;

/**
 *  首次选中者
 */
//@property(nonatomic,assign)NSInteger                firstIndex;

/**
 *  只有当前是一个TableViewController时，tableView才存在。
 */
@property(nonatomic,weak)UITableView                *tableView;
/**
 *  当前视图,包括tablView，也包括不为TableView时的View，重要
 */
@property(nonatomic,weak)UIView                     *currentView;
/**
 *  当前视图控制器
 */
@property(nonatomic,weak)UIViewController           *currentViewController;

/**
 *  创建不带头的SegumentView
 *
 *  @param frame
 *
 *  @return
 */
- (instancetype)initWithoutTittleViewWithFrame:(CGRect)frame;

/**
 *  如果当前页面的控制器是tableViewController，则对此tableView执行刷新刷新
 */
-(void)tableViewRefresh;


@end

NS_ASSUME_NONNULL_END
