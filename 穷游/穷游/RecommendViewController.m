//
//  RecommendViewController.m
//  穷游
//
//  Created by 罗秋生 on 16/8/19.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "RecommendViewController.h"
/**
 *  CELL
 */
#import "RecommendTableViewCell.h"
/**
 *  Third Part Library
 */
#import "PureLayout.h" // AUTOLAYOUT
/**
 *  宏定义
 */
#define RECOMMENDCELL @"recommendCell"

@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *recommendTableView;
@property (nonatomic, strong) NSMutableArray *recommendArray;    // 数据源

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
        _recommendTableView.delegate = self;
        _recommendTableView.dataSource = self;
    }
    return _recommendTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeNavigation];
    [self initializeDataSource];
    [self getDataFromNetwork];
    [self registerUITableViewCell];
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
 *  获取网络数据
 */
- (void)getDataFromNetwork {
    
}

/**
 *  注册UITableViweCell
 */
- (void)registerUITableViewCell {
    [self.recommendTableView registerNib:[UINib nibWithNibName:@"RecommendTableViewCell" bundle:nil] forCellReuseIdentifier:RECOMMENDCELL];
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

/**
 *  UITableViewDataSource
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    return cell;
    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECOMMENDCELL];
    return cell;
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
