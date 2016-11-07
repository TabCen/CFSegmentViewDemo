//
//  MainViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/11/7.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "MainViewController.h"
#import "NormalViewController.h"

static NSString *const ID_TableViewCell=@"ID_TableViewCell";

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_TableViewCell forIndexPath:indexPath];
    
    cell.textLabel.text=[NSString stringWithFormat:@"第%ld个",indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalViewController *detailViewController = [[NormalViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end