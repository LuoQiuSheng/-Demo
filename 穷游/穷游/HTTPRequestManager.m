//
//  HTTPRequestManager.m
//  穷游
//
//  Created by 罗秋生 on 16/8/24.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "AFNetworking.h"

@implementation HTTPRequestManager

+ (HTTPRequestManager *)shareIntance {
    
    static HTTPRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTTPRequestManager alloc] init];
    });
    return manager;
}

#pragma mark GET REQUEST
- (void)GETDataFromNetworkWithURL:(NSString *)URL andPage:(NSInteger)page andSuccess:(HTTPRequestManagerSuccess)success andFailed:(HTTPRequestManagerFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data             = [NSJSONSerialization dataWithJSONObject:responseObject
                                                                   options:NSJSONWritingPrettyPrinted
                                                                     error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        success(self, dictionary);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(self, error);
    }];
}

#pragma mark POST REQUEST
- (void)POSTDictionaryToNetworkWithURL:(NSString *)URL andDictionary:(NSDictionary *)dictionary andPage:(NSInteger)page andSuccess:(HTTPRequestManagerSuccess)success andFailed:(HTTPRequestManagerFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data             = [NSJSONSerialization dataWithJSONObject:responseObject
                                                                   options:NSJSONWritingPrettyPrinted
                                                                     error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        success(self, dictionary);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed(self, error);
    }];
}

@end
