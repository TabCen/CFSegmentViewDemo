//
//  MainViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/11/7.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "MainViewController.h"
#import "NormalViewController.h"
#import "WithRefreshViewController.h"
#import "TittleViewController.h"
#import "InScrollViewViewController.h"

static NSString *const ID_TableViewCell=@"ID_TableViewCell";

@interface MainViewController ()

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
                        @"默认情况",
                        @"滑动自动刷新",
                        @"标题独立设置（导航栏）",
                        @"选择器在UIScrollView中，控制事件传递",
                       ];
    
    self.navigationItem.title=@"选择器";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID_TableViewCell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_TableViewCell forIndexPath:indexPath];
//    cell.textLabel.text=[NSString stringWithFormat:@"第%ld个",indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            NormalViewController *detailViewController = [[NormalViewController alloc] init];
            [self.navigationController pushViewController:detailViewController animated:YES];
        }break;
        case 1:{
            WithRefreshViewController *withRefreshVC=[[WithRefreshViewController alloc]init];
            [self.navigationController pushViewController:withRefreshVC animated:YES];
        }break;
        case 2:{
            TittleViewController *tittleVC=[[TittleViewController alloc]init];
            [self.navigationController pushViewController:tittleVC animated:YES];
        }break;
        case 3:{
            InScrollViewViewController *inScrollVC = [[InScrollViewViewController alloc]init];
            [self.navigationController pushViewController:inScrollVC animated:YES];
        }break;
        default:
            break;
    }
}


@end
