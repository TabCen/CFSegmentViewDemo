//
//  CFSegmentView.m
//  CFOCS
//
//  Created by  chenfei on 16/6/14.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "CFSegumentView.h"

#define CF_COLOR(R,G,B)  [UIColor colorWithRed:R green:G blue:B alpha:1]
#define CF_COLOR_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kColor_Tittle_Selected CF_COLOR_RGB(0xEB3434)
#define kColor_Tittle_Bar CF_COLOR_RGB(0xFFFFFF)
#define kColor_Tittle CF_COLOR_RGB(0x333333)


#define TITTLES_MAX_NUM 5

static NSString * const ID=@"CotentCollectionViewIdentify";

NS_ASSUME_NONNULL_BEGIN
@interface CFSegumentView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,copy) NSMutableArray<__kindof UITableView *> *tableViews;

@property(nonatomic,copy) NSMutableDictionary *dictTableViews;

@property(nonatomic,strong)UIScrollView     *tittleScrollView;
@property(nonatomic,strong)UIView           *tittleView;
@property(nonatomic,strong)UICollectionView *contentCollectionView;

@property(nonatomic,assign)CGFloat          kWidth;
@property(nonatomic,assign)CGFloat          kHeight;

@property(nonatomic,assign)CGFloat          collection_Y;
/**
 *  当前页
 */
@property(nonatomic)NSInteger                       currentIndex;
@property(nonatomic,assign)NSInteger        tableViewsNum;  //tableViwes的个数
@property(nonatomic,assign)NSInteger        tittlesNum;     //头部标签的个数


@property(nonatomic,strong)UIView           *tittleScrollIndicatorView;     //  tittleView的指示标志
@property(nonatomic,strong)UICollectionViewFlowLayout *fl;

@property(nonatomic,assign)NSInteger                     lastSelectedTittleButtonTag;

@end
NS_ASSUME_NONNULL_END

@implementation CFSegumentView

@synthesize tableViews =_tableViews;
@synthesize tittles=_tittles;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showTittle=YES;
        self.tittleBig=YES;
        self.currentIndex=0;
        
        [self addContentCollectionView];
    }
    return self;
}
- (instancetype)initWithoutTittleViewWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.tittleBig=YES;
        self.kWidth=self.frame.size.width;
        self.kHeight=self.frame.size.height;
        self.showTittle=NO;
        self.showTittleScrollIndicator=NO;
        self.currentIndex=0;
        [self addContentCollectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tittleBig=YES;
        self.kWidth=self.frame.size.width;
        self.kHeight=self.frame.size.height;
        self.showTittle=YES;
        
        self.showTittleScrollIndicator=NO;
        self.currentIndex=0;
        [self addContentCollectionView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_showTittle) {
        self.tittleScrollView.frame=CGRectMake(0, 0, self.frame.size.width, self.tittleViewHeight);
        CGFloat tmpHeight=self.tittleViewHeight;
        self.fl.itemSize=CGSizeMake(_kWidth, _kHeight-tmpHeight);
        self.contentCollectionView.frame=CGRectMake(0, self.tittleViewHeight, _kWidth, _kHeight-self.tittleViewHeight);
    }else{
        self.contentCollectionView.frame=CGRectMake(0, 0, _kWidth, _kHeight);
    }
}

#pragma mark - 添加子视图
-(void)addTittleView{
    //如果_showtittle设置为NO则直接跳出，不设置
    if (!_showTittle) {
        return;
    }
    
    //将tittleNum大于的滚动情况暂时去除
    if (_tittlesNum>kDEFAULT_MAX_TITTLES_NUM) {
        
        self.tittleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.tittleViewHeight)];
        _tittleScrollView.backgroundColor=kColor_Tittle;
        _tittleScrollView.bounces=NO;
        
        CGFloat oneTittleWidth=_kWidth/kDEFAULT_MAX_TITTLES_NUM;    //大于最大个数时先计算一个tittle的宽度
        //再计算tittleView的内容滚动最大值
        _tittleScrollView.contentSize=CGSizeMake(oneTittleWidth*_tittlesNum, -100);
        
        for (int i=0; i<_tittlesNum; ++i) {
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i*oneTittleWidth, 0, oneTittleWidth, self.tittleViewHeight)];
            [button setBackgroundColor:kColor_Tittle_Bar];
            [button setTitle:_tittles[i] forState:UIControlStateNormal];
            [button setTitleColor:kColor_Tittle forState:UIControlStateNormal];
            [button setTitleColor:kColor_Tittle_Selected forState:UIControlStateSelected];
            button.titleLabel.font=[UIFont systemFontOfSize:15];
            
            button.tag=200+i;
            [button addTarget:self action:@selector(tittleButtonSellect:) forControlEvents:UIControlEventTouchUpInside];
            
            if (0==i) {
                button.selected=YES;
                if (self.tittleBig) {
                    button.titleLabel.font=[UIFont systemFontOfSize:17];
                }
                _lastSelectedTittleButtonTag=(int)button.tag;
            }
            
            [_tittleScrollView addSubview:button];
        }
        
        
        [self addSubview:_tittleScrollView];
        
        return;
    }
       //将tittleNum小于等于的滚动情况------暂时
    self.tittleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.tittleViewHeight)];
    
    for (int i=0; i<self.tittlesNum; ++i) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i*_kWidth/_tittlesNum, 0, _kWidth/_tittlesNum, _tittleViewHeight)];
        [button setBackgroundColor:kColor_Tittle_Bar];
        [button setTitle:_tittles[i] forState:UIControlStateNormal];
        [button setTitleColor:kColor_Tittle forState:UIControlStateNormal];
        [button setTitleColor:kColor_Tittle_Selected forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        
        button.tag=200+i;
        [button addTarget:self action:@selector(tittleButtonSellect:) forControlEvents:UIControlEventTouchUpInside];
        
        if (0==i) {
            button.selected=YES;
            if (self.tittleBig) {
                button.titleLabel.font=[UIFont systemFontOfSize:17];
            }
            _lastSelectedTittleButtonTag=(int)button.tag;
        }
        
        [_tittleView addSubview:button];
    }
    
    UIView *buttonLine=[[UIView alloc]initWithFrame:CGRectMake(0, _tittleView.frame.size.height-0.5, _kWidth, 0.5)];
    
    buttonLine.backgroundColor=CF_COLOR_RGB(0xDDDDDD);
//    buttonLine.backgroundColor=[UIColor blueColor];
    [_tittleView addSubview:buttonLine];
    
    [_tittleView bringSubviewToFront:buttonLine];
    
    if (self.showTittleScrollIndicator) {
        
        self.tittleScrollIndicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, _tittleView.frame.size.height-2, _kWidth/_tittlesNum, 2)];
        
        _tittleScrollIndicatorView.backgroundColor=[UIColor redColor];
        
        [_tittleView addSubview:_tittleScrollIndicatorView];
        
        [_tittleView bringSubviewToFront:_tittleScrollIndicatorView];
        
    }
    
    [self addSubview:_tittleView];
}

-(void)addContentCollectionView{
    self.fl=[[UICollectionViewFlowLayout alloc]init];
    _fl.minimumLineSpacing=0;
    _fl.minimumInteritemSpacing=0;
    _fl.headerReferenceSize=CGSizeZero;
    _fl.footerReferenceSize=CGSizeZero;
    _fl.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    //当tittleView不显示的时候
    
    _fl.itemSize=CGSizeMake(_kWidth, _kHeight-_collection_Y);
    
    self.contentCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, _collection_Y, _kWidth, _kHeight-_collection_Y) collectionViewLayout:_fl];
    [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    _contentCollectionView.backgroundColor=[UIColor whiteColor];
    _contentCollectionView.pagingEnabled=YES;
    _contentCollectionView.delegate=self;
    _contentCollectionView.dataSource=self;
    _contentCollectionView.showsHorizontalScrollIndicator=NO;
    _contentCollectionView.bounces=NO;
    [self addSubview:_contentCollectionView];
    
}


#pragma mark - 按钮被点击
-(void)tittleButtonSellect:(id)sender{
    UIButton *button=(UIButton *)sender;
    self.currentIndex=button.tag-200;
    
    if (!_showTittle) {
        
        if (button.tag!=_lastSelectedTittleButtonTag) {
            [self buttonStatusChange:button.tag];
            
            _contentCollectionView.contentOffset=CGPointMake((button.tag-200)*_kWidth, 0);
        }
        return;
    }
    
    if (button.tag!=_lastSelectedTittleButtonTag) {
        [self buttonStatusChange:button.tag];
        
        _contentCollectionView.contentOffset=CGPointMake((button.tag-200)*_kWidth, 0);
    }
    
}

//按钮选中状态
-(void)tittleButtonOnClicked:(NSInteger)tag{
    
    self.currentIndex=tag-200;
    //这个地方要自己定义，否则会出错
    if (!_showTittle) {
        if (tag!=_lastSelectedTittleButtonTag) {
            [self buttonStatusChange:tag];
        }
        return;
    }
    
    if (tag!=_lastSelectedTittleButtonTag) {
        [self buttonStatusChange:tag];
    }
}

//按钮状态修改
-(void)buttonStatusChange:(NSInteger)tag{
    UIButton *laseButton=(UIButton*)[self viewWithTag:_lastSelectedTittleButtonTag];
    laseButton.selected=NO;
    laseButton.titleLabel.font=[UIFont systemFontOfSize:15];
    UIButton *button=(UIButton*)[self viewWithTag:tag];
    button.selected=YES;
    if (self.tittleBig) {
        button.titleLabel.font=[UIFont systemFontOfSize:17];
    }
    _lastSelectedTittleButtonTag=tag;
}


#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        if (_showTittleScrollIndicator) {
            CGFloat offset=1.0f*scrollView.contentOffset.x/_tittlesNum;
            CGPoint oldPoint=self.tittleScrollIndicatorView.layer.position;
            self.tittleScrollIndicatorView.layer.position=CGPointMake(_tittleScrollIndicatorView.frame.size.width/2.0f+offset, oldPoint.y);
        }
        
        if (!_showTittle) {
            UIView *lineButton=[self.selfViewController.navigationController.navigationBar viewWithTag:1000];
            CGFloat offset=(1.0f*scrollView.contentOffset.x)/_tableClasses.count;
            CGPoint oldPoint=lineButton.layer.position;
            lineButton.layer.position=CGPointMake(lineButton.frame.size.width/2.0f+offset, oldPoint.y);
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int i=scrollView.contentOffset.x/scrollView.frame.size.width;
    
    [self tittleButtonOnClicked:200+i];
    
}

#pragma mark - CollectionViewDelegate&dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tableViewsNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    /**
     *  将所有复用视图的子视图删除
     */
    if (0!=cell.contentView.subviews.count) {
        for(UIView *view in cell.contentView.subviews){
            [view removeFromSuperview];
        }
    }
    
    NSString *indexStr=[NSString stringWithFormat:@"%ld",(long)indexPath.item];

    if ([_dictTableViews objectForKey:indexStr]) {
        if ([[_tableClasses[indexPath.item] class] isSubclassOfClass:[UITableViewController class]]) {
            UIView *tableView=((UITableViewController*)[_dictTableViews objectForKey:indexStr]).view;
            self.tableView=(id)tableView;
            self.currentView=_tableView;
        }else if ([[_tableClasses[indexPath.item] class] isSubclassOfClass:[UIViewController class]]){
            UIView *view=((UIViewController*)[_dictTableViews objectForKey:indexStr]).view;
            self.tableView=nil;
            self.currentView=view;
        }
    }else{
        if ([[_tableClasses[indexPath.item] class] isSubclassOfClass:[UITableViewController class]]) {
            UITableViewController *tempTableViewVC=_tableClasses[indexPath.item].new;
            //当tittleView不显示的时候
            tempTableViewVC.view.frame=CGRectMake(0, 0, _kWidth, _kHeight-_collection_Y);
            [self.dictTableViews setObject:tempTableViewVC forKey:indexStr];
            self.tableView=tempTableViewVC.tableView;
            self.currentView=_tableView;
        }else if ([[_tableClasses[indexPath.item] class] isSubclassOfClass:[UIViewController class]]){
            UIViewController *tempVC=_tableClasses[indexPath.item].new;
            //当tittleView不显示的时候
            tempVC.view.frame=CGRectMake(0, 0, _kWidth, _kHeight-_collection_Y);
            [self.dictTableViews setObject:tempVC forKey:indexStr];
            self.tableView=nil;
            self.currentView=tempVC.view;
        }
    }
    //最后将当前视图添加到cell的contentView中
    [cell.contentView addSubview:_currentView];
    
    //每次刷新TableView的方法
    if (self.scrollThenRefreshing&&self.tableView) {
        [self tableViewRefresh];
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(CFSegumentView:currentIndex:)]) {
        [self.delegate performSelector:@selector(CFSegumentView:currentIndex:) withObject:self withObject:[NSString stringWithFormat:@"%ld",(long)self.currentIndex]];
    }
    
    return cell;
}

#pragma mark - set、get方法

//-(UIView *)currentView{
//    
//    NSString *indeStr=[NSString stringWithFormat:@"%ld",self.currentIndex];
//    _currentView=((UIViewController *)[self.dictTableViews objectForKey:indeStr]).view;
//    
//    return _currentView;
//}

//-(void)setCurrentIndex:(NSInteger)currentIndex{
//    _currentIndex=currentIndex;
//    
//    UIButton *clickedButton=(UIButton*)[self viewWithTag:(200+_currentIndex)];
//    
//    [clickedButton sendActionsForControlEvents:UIControlEventTouchUpInside];
////    [self tittleButtonSellect:clickedButton];
//}

//-(void)setFirstIndex:(NSInteger)firstIndex{
//    _firstIndex=firstIndex;
//    UIButton *clickedButton=(UIButton*)[self viewWithTag:(200+_firstIndex)];
//    [clickedButton sendActionsForControlEvents:UIControlEventTouchUpInside];
//    [self tittleButtonSellect:clickedButton];
//    _contentCollectionView.contentOffset=CGPointMake(firstIndex*_kWidth, 0);
//}

-(UIViewController *)currentViewController{
    NSString *indeStr=[NSString stringWithFormat:@"%ld",self.currentIndex];
    _currentViewController=(UIViewController *)[self.dictTableViews objectForKey:indeStr];
    
    return _currentViewController;
}

-(void)setTittles:(NSArray<NSString *> *)tittles{
    _tittles=tittles;
    if (_tittles) {
        self.tittlesNum=tittles.count;
        [self addTittleView];
    }else{
        self.tittlesNum=kDEFAULT_TITTLES_NUM;
    }
}

-(NSArray<NSString *> *)tittles{
    if (!_tittles) {
        _tittles=@[@"测试"];
    }
    return _tittles;
}

-(void)setTableViews:(NSMutableArray<__kindof UITableView *> *)tableViews{
    _tableViews=tableViews;
    if (_tableViews) {
        self.tableViewsNum=tableViews.count;
    }else{
        self.tableViewsNum=kDEFAULT_TABLEVIEWS_NUM;
    }
}

-(NSMutableArray<UITableView *> *)tableViews{
    if (!_tableViews) {
        //当tittleView不显示的时候
        
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _collection_Y, self.frame.size.width, self.frame.size.height-_collection_Y)];
        
        tableView.backgroundColor=[UIColor whiteColor];
        _tableViews=[[NSMutableArray alloc]initWithArray:@[tableView]];
    }
    return _tableViews;
}

-(void)setTableClasses:(NSArray<Class> *)tableClasses{
    _tableClasses=tableClasses;
    if (_tableClasses) {
        self.tableViewsNum=tableClasses.count;
    }else{
        self.tableViewsNum=kDEFAULT_TABLEVIEWS_NUM;
    }
}

-(NSMutableDictionary *)dictTableViews{
    if (!_dictTableViews) {
        _dictTableViews=[[NSMutableDictionary alloc]init];
    }
    return _dictTableViews;
}

-(BOOL)showTittle{
    return _showTittle;
}

-(CGFloat)tittleViewHeight{
    if (!_tittleViewHeight) {
        _tittleViewHeight=kTittleHeight;
    }
    return _tittleViewHeight;
}

-(CGFloat)collection_Y{
    return self.showTittle?self.tittleViewHeight:0;
}

#pragma mark - 刷新方法
-(void)tableViewRefresh{
    
    
}

@end
