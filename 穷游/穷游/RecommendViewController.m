//
//  RecommendViewController.m
//  穷游
//
//  Created by 罗秋生 on 16/8/19.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "RecommendViewController.h"
/**
 *  Third Part Library
 */
#import "PureLayout.h" // AUTOLAYOUT

@interface RecommendViewController ()

@property (nonatomic, strong) UITableView *recommendTableView;

@end

@implementation RecommendViewController

/**
 *  懒加载控件
 */
- (UITableView *)recommendTableView {
    if (!_recommendTableView) {
        _recommendTableView = [[UITableView alloc] initForAutoLayout];
        _recommendTableView.showsVerticalScrollIndicator = NO;
        _recommendTableView.showsHorizontalScrollIndicator = NO;
    }
    return _recommendTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeNavigation];
    [self initializeDataSource];
    [self initializeUIInterface];
}

/**
 *  初始化导航栏
 */
- (void)initializeNavigation {
//    self.navigationController.navigationBarHidden = YES;
}

/**
 *  初始化数据源
 */
- (void)initializeDataSource {
    
}

/**
 *  初始化UI界面
 */
- (void)initializeUIInterface {
    
    [self.view addSubview:self.recommendTableView];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
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
