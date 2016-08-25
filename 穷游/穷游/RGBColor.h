//
//  RGBColor.h
//  穷游
//
//  Created by 罗秋生 on 16/8/25.
//  Copyright © 2016年 罗秋生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RGBColor : NSObject

+(UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
