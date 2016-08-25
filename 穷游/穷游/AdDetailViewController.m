//
//  AdDetailViewController.m
//  穷游
//
//  Created by 罗秋生 on 16/8/25.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "AdDetailViewController.h"

@interface AdDetailViewController ()

@property (nonatomic, strong) UIWebView *adDetailWebView;

@end

@implementation AdDetailViewController

/**
 *  懒加载
 */
- (UIWebView *)adDetailWebView {
    
    if (!_adDetailWebView) {
        _adDetailWebView = [[UIWebView alloc] initForAutoLayout];
        _adDetailWebView.backgroundColor = [UIColor lightGrayColor];
    }
    return _adDetailWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUIInterface];
}

#pragma mark 初始化数据源
- (void)initializeDataSource {
    
    [self.adDetailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]]];
}

#pragma mark 初始化UI界面
- (void)initializeUIInterface {
    
    [self.view addSubview:self.adDetailWebView];
    [_adDetailWebView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_adDetailWebView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_adDetailWebView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_adDetailWebView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:46];
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
