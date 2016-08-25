//
//  RecommendTableViewCell.h
//  穷游
//
//  Created by 罗秋生 on 16/8/24.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@protocol RecommendTableViewCellDelegate <NSObject>

- (void)adBannerViewBeClickedAndMoveToDetailViewControllerWith:(int)index;

@end

@interface RecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) id <RecommendTableViewCellDelegate> delegate;

- (void)configureCellWithModel:(RecommendModel *)model andIndexPath:(NSIndexPath *)indexPath;

@end
