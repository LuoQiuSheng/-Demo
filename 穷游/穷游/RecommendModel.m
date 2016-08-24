//
//  RecommendModel.m
//  穷游
//
//  Created by 罗秋生 on 16/8/24.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    NSDictionary *jsonKey = @{
                              @"data"        :@"data",
                              @"slide"       :@"data.slide",
                              @"keyword"     :@"data.keyword",
                              @"commentEntry":@"data.comment_entry",
                              @"feed"        :@"data.feed",
                              @"entry"       :@"data.feed.entry"
                              };
    return jsonKey;
}

@end
