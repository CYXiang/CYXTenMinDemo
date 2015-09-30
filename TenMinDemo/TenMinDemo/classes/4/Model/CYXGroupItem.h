//
//  CYXGroupItem.h
//  
//
//  Created by Macx on 15/9/11.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYXGroupItem : NSObject

/** 头部标题 */
@property (strong, nonatomic) NSString * headerTitle;
/** 尾部标题 */
@property (strong, nonatomic) NSString * footerTitle;

/** 组中的行数组 */
@property (strong, nonatomic) NSArray * items;


@end
