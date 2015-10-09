//
//  CYXOneViewController.m
//  
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "CYXOneViewController.h"
#import "CYXCell.h"
#import <AFNetworking.h>

@interface CYXOneViewController ()

@end

@implementation CYXOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 90;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self loadData];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
}

- (void)loadData{
    
    NSString *url = @"http://apis.haoservice.com/lifeservice/cook/query?";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"menu"] = @"西红柿";
    params[@"pn"] = @"3";
    params[@"rn"] = @"10";
    params[@"key"] = @"2ba215a3f83b4b898d0f6fdca4e16c7c";

    
    
    [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/Macx/Desktop/杂/tags.plist" atomically:YES];
        
       
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"失败 %@",error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    return cell;
}

@end
