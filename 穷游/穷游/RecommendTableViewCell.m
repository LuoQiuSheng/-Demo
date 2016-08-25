//
//  RecommendTableViewCell.m
//  穷游
//
//  Created by 罗秋生 on 16/8/24.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "RecommendTableViewCell.h"
#import "AdBannerView.h"

@interface RecommendTableViewCell ()<AdBannerViewDelegate>

@property (nonatomic, strong) AdBannerView *adBannerView;
@property (nonatomic, strong) UIButton     *searchButton;

@end

@implementation RecommendTableViewCell

- (UIButton *)searchButton {
    
    if (!_searchButton) {
        _searchButton                    = [[UIButton alloc] initForAutoLayout];
        _searchButton.layer.cornerRadius = 4;
        _searchButton.layer.borderWidth  = 1;
        _searchButton.layer.borderColor  = MAINCOLOR.CGColor;
        _searchButton.clipsToBounds      = YES;
        _searchButton.backgroundColor    = [UIColor clearColor];
        _searchButton.titleLabel.font    = [UIFont systemFontOfSize:13];
    }
    return _searchButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark CONFIGURE CELL
- (void)configureCellWithModel:(RecommendModel *)model andIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *slideArray            = model.slide;
    NSMutableArray *imageViewArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < slideArray.count; i ++) {
        NSDictionary *dictionary         = [slideArray objectAtIndex:i];
        
        UIImageView *imageView           = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, 200)];
        imageView.contentMode            = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds          = YES;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"photo"]]];
        
        [imageViewArray addObject:imageView];
    }
    self.adBannerView = [[AdBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200) Delegate:self andImageViewArray:imageViewArray andNameArray:nil];
    [self.contentView addSubview:self.adBannerView];
    
    [self.contentView addSubview:self.searchButton];
    [_searchButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.adBannerView withOffset:10];
    [_searchButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_searchButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_searchButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    [_searchButton setTitle:model.keyword forState:UIControlStateNormal];
    [_searchButton setTitle:model.keyword forState:UIControlStateHighlighted];
    [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

#pragma mark AdBannerViewDelegate
- (void)adBannerView:(AdBannerView *)adBannerView itemIndex:(int)index {
    NSLog(@"%d",index);
    [self.delegate adBannerViewBeClickedAndMoveToDetailViewControllerWith:index];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
