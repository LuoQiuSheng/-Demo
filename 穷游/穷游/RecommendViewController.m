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

@interface RecommendViewController ()<UITableViewDelegate, UITableViewDataSource, RecommendTableViewCellDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView    *recommendTableView;
@property (nonatomic, strong) NSMutableArray *recommendArray;     // 数据源
@property (nonatomic, strong) RecommendModel *recommentModel;
@property (nonatomic, assign) NSInteger       page;

@end

@implementation RecommendViewController

#pragma mark 懒加载控件
- (UITableView *)recommendTableView {
    
    if (!_recommendTableView) {
        _recommendTableView                                = [[UITableView alloc] initForAutoLayout];
        _recommendTableView.showsVerticalScrollIndicator   = NO;
        _recommendTableView.showsHorizontalScrollIndicator = NO;
        _recommendTableView.delegate                       = self;
        _recommendTableView.dataSource                     = self;
        _recommendTableView.emptyDataSetSource             = self;
        _recommendTableView.emptyDataSetDelegate           = self;
        _recommendTableView.tableFooterView                = [UIView new];
        _recommendTableView.backgroundColor                = [RGBColor colorWithHexString:@"#F0F0F0"];
        _recommendTableView.mj_header                      = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _recommendTableView.mj_footer                      = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    _page = 1;
}

#pragma mark 获取网络数据
- (void)getDataFromNetwork {
    
    [[HTTPRequestManager shareIntance] GETDataFromNetworkWithURL:RECOMMENDVIEWCONTROLLER andPage:_page andSuccess:^(HTTPRequestManager *manager, id model) {
        
        if (_page == 1) {
            [_recommendArray removeAllObjects];
        }
        
        _recommentModel = [MTLJSONAdapter modelOfClass:[RecommendModel class] fromJSONDictionary:model error:nil];
        [_recommendArray addObject:_recommentModel];
        
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
    
    return [_recommentModel.entry count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECOMMENDCELL];
    cell.delegate                = self;
    cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    [cell configureCellWithModel:_recommentModel andIndexPath:indexPath];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height;
    
    if (indexPath.row == 0) {
        height = 260;
    }else {
        
        NSDictionary *dictionary       = [_recommentModel.entry objectAtIndex:indexPath.row - 1];
        NSDictionary *authorDictionary = [dictionary objectForKey:@"author"];
        NSString     *titleString      = [dictionary objectForKey:@"title"];
        NSString     *contentString    = [dictionary objectForKey:@"subject"];
        
        height = 240;
        if ([authorDictionary objectForKey:@"pic"] != nil || [authorDictionary objectForKey:@"username"] != nil) {
            height += 60;
        }
        if (titleString != nil) {
            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
            CGSize titileSize       = [titleString boundingRectWithSize:CGSizeMake(SCREENWIDTH - 16, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
            height                 += titileSize.height;
        }
        if (contentString != nil) {
            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
            CGSize contentSize      = [contentString boundingRectWithSize:CGSizeMake(SCREENWIDTH - 16, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
            height                 += contentSize.height;
        }
    }
    return height;
}

#pragma mark RecommendTableViewCellDelegate
- (void)adBannerViewBeClickedAndMoveToDetailViewControllerWith:(int)index {
    
    NSLog(@"%d",index);
    NSDictionary *dictionary      = [_recommentModel.slide objectAtIndex:index];
    
    AdDetailViewController *firVC = [[AdDetailViewController alloc] init];
    firVC.URL                     = [dictionary objectForKey:@"url"];
    [self.navigationController pushViewController:firVC animated:YES];
}

#pragma mark Data Source Implementation
/* The image for the empty state */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSLog(@"imageForEmptyDataSet:empty_placeholder");
    return [UIImage imageNamed:@"icon_online"];
}

/* The image view animation */
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSLog(@"imageAnimationForEmptyDataSet");
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue   = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue     = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration    = 0.25;
    animation.cumulative  = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

/* The attributed string for the description of the empty state */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSLog(@"descriptionForEmptyDataSet:您还没有上传照片");
    
    NSString *text = @"网络加载出错, 点击屏幕重试";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraph.alignment                = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/* The attributed string to be used for the specified button state */
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    
//    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    
//    return [[NSAttributedString alloc] initWithString:@"点击上传照片" attributes:attributes];
//}

/* Additionally, you can also adjust the vertical alignment of the content view
 (ie: useful when there is tableHeaderView visible): */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSLog(@"verticalOffsetForEmptyDataSet");
    return -self.recommendTableView.tableHeaderView.frame.size.height/2.0f;
}

/* Finally, you can separate components from each other (default separation is 11 pts): */
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSLog(@"spaceHeightForEmptyDataSet");
    return 20.0f;
}

#pragma mark Delegate Implementation
/* Asks to know if the empty state should be rendered and displayed (Default is YES) : */
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    NSLog(@"emptyDataSetShouldDisplay");
    return YES;
}

/* Asks for interaction permission (Default is YES) : */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    NSLog(@"emptyDataSetShouldAllowTouch");
    return YES;
}

/* Asks for scrolling permission (Default is NO) : */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    NSLog(@"emptyDataSetShouldAllowScroll");
    return NO;
}

/* Asks for image view animation permission (Default is NO) : */
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    NSLog(@"emptyDataSetShouldAllowImageViewAnimate");
    return YES;
}

/* Notifies when the dataset view was tapped: */
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    NSLog(@"emptyDataSetDidTapView");
    // Do something
    [self.recommendTableView reloadData];
}

/* Notifies when the data set call to action button was tapped: */
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    NSLog(@"emptyDataSetDidTapButton");
    // Do something
}

#pragma mark MJRefresh
- (void)loadNewData {
    NSLog(@"刷新数据");
    _page = 1;
    [self getDataFromNetwork];
}

- (void)loadMoreData {
    NSLog(@"加载更多数据");
    _page ++;
    [self getDataFromNetwork];
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
