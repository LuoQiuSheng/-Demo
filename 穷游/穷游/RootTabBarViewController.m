//
//  RootTabBarViewController.m
//  穷游
//
//  Created by 罗秋生 on 16/8/19.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "RootTabBarViewController.h"
/**
 *  BaseNavigationController
 */
#import "BaseNavigationController.h"
/**
 *  ViewControllers
 */
#import "RecommendViewController.h"
#import "DestinationViewController.h"
#import "TravelMallViewController.h"
#import "CommunityViewController.h"
#import "MineViewController.h"
/**
 *  Macro definition
 */
#define classKey    @"rootVCClassString"
#define titleKey    @"title"
#define imageKey    @"imageName"
#define selImageKey @"selectedImageName"
#define themeColor  [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *childItemsArray = @[
                                 @{classKey:@"RecommendViewController",
                                   titleKey:@"推荐",
                                   imageKey:@"",
                                selImageKey:@"",},
                                 @{classKey:@"DestinationViewController",
                                   titleKey:@"目的地",
                                   imageKey:@"",
                                selImageKey:@"",},
                                 @{classKey:@"TravelMallViewController",
                                   titleKey:@"旅游商城",
                                   imageKey:@"",
                                selImageKey:@"",},
                                 @{classKey:@"CommunityViewController",
                                   titleKey:@"社区",
                                   imageKey:@"",
                                selImageKey:@"",},
                                 @{classKey:@"MineViewController",
                                   titleKey:@"我的",
                                   imageKey:@"",
                                selImageKey:@"",}];
    
    [childItemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dictionary = (NSDictionary *)obj;
        UIViewController *vc = [NSClassFromString(dictionary[classKey]) new];
        vc.title = dictionary[titleKey];
        
        BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = navigationController.tabBarItem;
        item.title = dictionary[titleKey];
        item.image = [UIImage imageNamed:dictionary[imageKey]];
        item.selectedImage = [[UIImage imageNamed:dictionary[selImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:themeColor} forState:UIControlStateSelected];
        [self addChildViewController:navigationController];
    }];
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
