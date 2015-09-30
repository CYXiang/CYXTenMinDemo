//
//  CYXSettingItem.h
//  
//
//  Created by Macx on 15/9/11.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CYXSettingItem : NSObject

@property (strong, nonatomic) NSString * title;/**< 标题 */

+ (instancetype)itemWithtitle:(NSString *)title;/**< 设置标题值 类方法 */

@end
