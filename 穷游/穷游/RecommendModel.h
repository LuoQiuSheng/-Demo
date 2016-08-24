//
//  RecommendModel.h
//  穷游
//
//  Created by 罗秋生 on 16/8/24.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RecommendModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSString     *keyword;
@property (nonatomic, strong) NSArray      *slide;
@property (nonatomic, strong) NSDictionary *commentEntry;
@property (nonatomic, strong) NSDictionary *feed;
@property (nonatomic, strong) NSArray      *entry;

@end
