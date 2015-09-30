//
//  CYXSettingItem.m
//  
//
//  Created by Macx on 15/9/11.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "CYXSettingItem.h"

@implementation CYXSettingItem

+ (instancetype)itemWithtitle:(NSString *)title{
    
    CYXSettingItem *item = [[CYXSettingItem alloc]init];
    
    item.title = title;
    
    return item;
}

@end
