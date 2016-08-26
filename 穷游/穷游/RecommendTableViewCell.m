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

@property (nonatomic, strong) UIImageView  *detailCellImageView;
@property (nonatomic, strong) UILabel      *detailCellType;
@property (nonatomic, strong) UIImageView  *detailCellAutherIcon;
@property (nonatomic, strong) UILabel      *detailCellName;
@property (nonatomic, strong) UILabel      *detailCellTitle;
@property (nonatomic, strong) UILabel      *detailCellContent;
@property (nonatomic, strong) UIImageView  *detailCellIcon;

@end

@implementation RecommendTableViewCell

#pragma mark 懒加载
- (UIButton *)searchButton {
    
    if (!_searchButton) {
        _searchButton                    = [[UIButton alloc] initForAutoLayout];
        _searchButton.layer.cornerRadius = 4;
        _searchButton.layer.borderWidth  = 1;
        _searchButton.layer.borderColor  = MAINCOLOR.CGColor;
        _searchButton.clipsToBounds      = YES;
        _searchButton.backgroundColor    = [UIColor clearColor];
        _searchButton.titleLabel.font    = [UIFont systemFontOfSize:13];
        [_searchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (UIImageView *)detailCellImageView {
    
    if (!_detailCellImageView) {
        _detailCellImageView               = [[UIImageView alloc] initForAutoLayout];
        _detailCellImageView.contentMode   = UIViewContentModeScaleAspectFill;
        _detailCellImageView.clipsToBounds = YES;
    }
    return _detailCellImageView;
}

- (UILabel *)detailCellType {
    
    if (!_detailCellType) {
        _detailCellType                 = [[UILabel alloc] initForAutoLayout];
        _detailCellType.backgroundColor = MAINCOLOR;
        _detailCellType.font            = [UIFont systemFontOfSize:13];
        _detailCellType.textColor       = [UIColor whiteColor];
    }
    return _detailCellType;
}

- (UIImageView *)detailCellAutherIcon {
    
    if (!_detailCellAutherIcon) {
        _detailCellAutherIcon                    = [[UIImageView alloc] initForAutoLayout];
        _detailCellAutherIcon.clipsToBounds      = YES;
        _detailCellAutherIcon.layer.cornerRadius = _detailCellAutherIcon.frame.size.width / 2;
        _detailCellAutherIcon.layer.borderWidth  = 0.5;
        _detailCellAutherIcon.layer.borderColor  = [RGBColor colorWithHexString:@"#F0F0F0"].CGColor;
    }
    return _detailCellAutherIcon;
}

- (UILabel *)detailCellName {
    
    if (!_detailCellName) {
        _detailCellName           = [[UILabel alloc] initForAutoLayout];
        _detailCellName.textColor = [UIColor lightGrayColor];
        _detailCellName.font      = [UIFont systemFontOfSize:13];
    }
    return _detailCellName;
}

- (UILabel *)detailCellTitle {
    
    if (!_detailCellTitle) {
        _detailCellTitle           = [[UILabel alloc] initForAutoLayout];
        _detailCellTitle.textColor = [UIColor blackColor];
    }
    return _detailCellTitle;
}

- (UILabel *)detailCellContent {
    
    if (!_detailCellContent) {
        _detailCellContent           = [[UILabel alloc] initForAutoLayout];
        _detailCellContent.textColor = [UIColor lightGrayColor];
    }
    return _detailCellContent;
}

- (UIImageView *)detailCellIcon {
    
    if (!_detailCellIcon) {
        _detailCellIcon = [[UIImageView alloc] initForAutoLayout];
    }
    return _detailCellIcon;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark CONFIGURE CELL
- (void)configureCellWithModel:(RecommendModel *)model andIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
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
        [_searchButton setTitleColor:MAINCOLOR forState:UIControlStateHighlighted];
    }else {
        
        NSDictionary *dictionary = [model.entry objectAtIndex:indexPath.row - 1];
        
        [self.contentView addSubview:self.detailCellImageView];
        [_detailCellImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_detailCellImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_detailCellImageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_detailCellImageView autoSetDimension:ALDimensionHeight toSize:150];
        [_detailCellImageView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"cover"]] placeholderImage:[UIImage imageNamed:@"bg_detail_cover_default"]];
        
        [self.contentView addSubview:self.detailCellType];
        [_detailCellType autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [_detailCellType autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_detailCellType autoSetDimension:ALDimensionHeight toSize:28];
        _detailCellType.text = [NSString stringWithFormat:@"  %@  ",[dictionary objectForKey:@"column"]];
    }
}

#pragma mark AdBannerViewDelegate
- (void)adBannerView:(AdBannerView *)adBannerView itemIndex:(int)index {
    NSLog(@"%d",index);
    [self.delegate adBannerViewBeClickedAndMoveToDetailViewControllerWith:index];
}

#pragma mark SEARCH BUTTON CLICK ACTION
- (void)buttonClick:(UIButton *)sender {
    NSLog(@"button click");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
