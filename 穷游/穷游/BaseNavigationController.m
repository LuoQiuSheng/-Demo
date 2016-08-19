//
//  BaseNavigationController.m
//  穷游
//
//  Created by 罗秋生 on 16/8/19.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1];
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
