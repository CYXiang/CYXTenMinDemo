//
//  CYXTwoViewController.m
//  
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "CYXTwoViewController.h"
#import "CYXNormalCollectionViewController.h"
#import "CYXWaterflowController.h"
#import "CYXNewfeatureViewController.h"
#import "CYXLayoutViewController.h"

@interface CYXTwoViewController ()

@property (strong, nonatomic) NSArray *demos;

@end

@implementation CYXTwoViewController

static NSString * const ID = @"cell";

#pragma mark - 懒加载
- (NSArray *)demos {
    if (_demos == nil) {
        _demos = @[@"基本用法",@"新手引导页", @"瀑布流样式",@"自定义布局"];
    }
    
    return _demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CYXDemo";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = self.demos[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            [self.navigationController pushViewController:[[CYXNormalCollectionViewController alloc]init] animated:YES];
            
            break;
        } case 1:{
            [self.navigationController pushViewController:[[CYXNewfeatureViewController alloc]init] animated:YES];
            
            break;
        } case 2:{
            [self.navigationController pushViewController:[[CYXWaterflowController alloc]init] animated:YES];
            
            break;
        } case 3:{
            [self.navigationController pushViewController:[[CYXLayoutViewController alloc]init] animated:YES];
            
            break;
        }
            
    }
}

@end
