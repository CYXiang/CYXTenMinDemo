//
//  CYXOneViewController.m
//  
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "CYXOneViewController.h"
#import "CYXCell.h"
#import "CYXMenu.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#pragma mark - 全局常量
static NSString * const CYXRequestURL = @"http://apis.haoservice.com/lifeservice/cook/query?";
static NSString * const CYXCellID = @"cell";

@interface CYXOneViewController ()

/** 存放数据模型的数组 */
@property (strong, nonatomic) NSMutableArray * menus;

@end

@implementation CYXOneViewController

#pragma mark - life cycle 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 90;
    
    // 注册重用Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // 调用加载数据方法
    [self loadData];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
}

#pragma mark - private methods 私有方法
/**
 *  发送请求并获取数据方法
 */
- (void)loadData{
    
    // 请求参数（根据接口文档编写）
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"menu"] = @"西红柿";
    params[@"pn"] = @"1";
    params[@"rn"] = @"20";
    params[@"key"] = @"2ba215a3f83b4b898d0f6fdca4e16c7c";
    
    // 在AFN的block内使用，防止造成循环引用
    __weak typeof(self) weakSelf = self;
    
    [[AFHTTPSessionManager manager] GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"请求成功");
        
        // 利用MJExtension框架进行字典转模型
        weakSelf.menus = [CYXMenu objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        // 刷新数据（若不刷新数据会显示不出）
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"请求失败 原因：%@",error);
    }];
    
}

#pragma mark - UITableviewDatasource 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CYXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.menu = self.menus[indexPath.row];
    
    return cell;
}

#pragma mark - UITableviewDelegate 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
