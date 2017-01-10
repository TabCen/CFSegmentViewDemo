//
//  ViewController_Son1.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/11/7.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "ViewController_Son1.h"

#import "ViewController_GrandSon1.h"

@interface ViewController_Son1 ()

@end

@implementation ViewController_Son1


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"页面即将呈现1");
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 40)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)btnClicked{
    
    ViewController_GrandSon1 *grandSon = [[ViewController_GrandSon1 alloc]init];
    
    UIViewController *rootVC = [self getCurrentVC];
    
    [rootVC.navigationController pushViewController:grandSon animated:YES];
//    [self.navigationController pushViewController:vc animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
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


-(UIViewController *)getCurrentVC{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *) next;
        }
        next = next.nextResponder;
    }
    return nil;
}


@end
