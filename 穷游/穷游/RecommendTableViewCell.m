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

@end

@implementation RecommendTableViewCell

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
