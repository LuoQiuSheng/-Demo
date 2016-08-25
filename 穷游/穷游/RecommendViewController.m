//
//  RecommendViewController.m
//  穷游
//
//  Created by 罗秋生 on 16/8/19.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "RecommendViewController.h"
#import "AdDetailViewController.h"
/**
 *  CELL
 */
#import "RecommendTableViewCell.h"
/**
 *  宏定义
 */
#define RECOMMENDCELL @"recommendCell"
/**
 *  MODEL
 */
#import "RecommendModel.h"

@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource, RecommendTableViewCellDelegate>

@property (nonatomic, strong) UITableView    *recommendTableView;
@property (nonatomic, strong) NSMutableArray *recommendArray;     // 数据源
@property (nonatomic, strong) RecommendModel *recommentModel;

@end

@implementation RecommendViewController

#pragma mark 懒加载控件
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

#pragma mark 视图周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeNavigation];
    [self initializeDataSource];
    [self getDataFromNetwork];
}

#pragma mark  初始化导航栏
- (void)initializeNavigation {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBarHidden = YES;
}

#pragma mark 初始化数据源
- (void)initializeDataSource {
    
    _recommendArray = [[NSMutableArray alloc] init];
}

#pragma mark 获取网络数据
- (void)getDataFromNetwork {
    
    [[HTTPRequestManager shareIntance] GETDataFromNetworkWithURL:RECOMMENDVIEWCONTROLLER
                                                         andPage:1
                                                      andSuccess:^(HTTPRequestManager *manager, id model) {
        
        _recommentModel = [MTLJSONAdapter modelOfClass:[RecommendModel class]
                                                   fromJSONDictionary:model
                                                                error:nil];
        NSLog(@"%@",_recommentModel);
        [self registerUITableViewCell];
        [self initializeUIInterface];
                                                        
    } andFailed:^(HTTPRequestManager *manager, id model) {
        
        NSLog(@"recomment view controller error:%@",[model localizedDescription]);
    }];
}

#pragma mark 注册UITableViweCell
- (void)registerUITableViewCell {
    
    [self.recommendTableView registerClass:[RecommendTableViewCell class]
                    forCellReuseIdentifier:RECOMMENDCELL];
}

#pragma mark 初始化UI界面
- (void)initializeUIInterface {
    
    [self.view addSubview:self.recommendTableView];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_recommendTableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECOMMENDCELL];
    cell.delegate                = self;
    [cell configureCellWithModel:_recommentModel andIndexPath:indexPath];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

#pragma mark RecommendTableViewCellDelegate
- (void)adBannerViewBeClickedAndMoveToDetailViewControllerWith:(int)index {
    
    NSLog(@"%d",index);
    NSDictionary *dictionary      = [_recommentModel.slide objectAtIndex:index];
    
    AdDetailViewController *firVC = [[AdDetailViewController alloc] init];
    firVC.URL                     = [dictionary objectForKey:@"url"];
    [self.navigationController pushViewController:firVC animated:YES];
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
