//
//  HTTPRequestManager.h
//  穷游
//
//  Created by 罗秋生 on 16/8/24.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTTPRequestManager;

typedef void (^ HTTPRequestManagerSuccess) (HTTPRequestManager *manager, id model);
typedef void (^ HTTPRequestManagerFailed)  (HTTPRequestManager *manager, id model);

@interface HTTPRequestManager : NSObject

+ (HTTPRequestManager *)shareIntance;

- (void)GETDataFromNetworkWithURL:(NSString *)URL andPage:(NSInteger)page andSuccess:(HTTPRequestManagerSuccess)success andFailed:(HTTPRequestManagerFailed)failed;

- (void)POSTDictionaryToNetworkWithURL:(NSString *)URL andDictionary:(NSDictionary *)dictionary andPage:(NSInteger)page andSuccess:(HTTPRequestManagerSuccess)success andFailed:(HTTPRequestManagerFailed)failed;

@end
