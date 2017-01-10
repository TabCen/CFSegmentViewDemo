//
//  ViewController_GrandSon1.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/12/26.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "ViewController_GrandSon1.h"

#import "UIViewController+BaseExtension.h"

@interface ViewController_GrandSon1 ()

@end

@implementation ViewController_GrandSon1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBar];
    
    self.navigationItem.title = @"孙控制器";
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
