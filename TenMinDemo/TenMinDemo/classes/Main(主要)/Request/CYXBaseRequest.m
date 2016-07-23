//
//  CYXBaseRequest.m
//  TenMinDemo
//
//  Created by apple开发 on 16/5/31.
//  Copyright © 2016年 CYXiang. All rights reserved.
//

#import "CYXBaseRequest.h"
#import "CYXHttpRequest.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

@implementation CYXBaseRequest


+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    
    [CYXHttpRequest get:url params:[self requestParams:params] success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  返回result下item_list 数组模型
 */
//+ (void)postItemListWithUrl:(NSString *)url param:(id)param
//                resultClass:(Class)resultClass
//                    success:(void (^)(id result))success
//                       warn:(void (^)(NSString *warnMsg))warn
//                    failure:(void (^)(NSError *error))failure
//               tokenInvalid:(void (^)())tokenInvalid
//{
//    
//    [self postBaseWithUrl:url param:param resultClass:resultClass
//                  success:^(id responseObj) {
//                      if (!resultClass || !responseObj[@"result"][@"list"]) {
//                          success(nil);
//                          return;
//                      }
//                      success([resultClass mj_objectArrayWithKeyValuesArray:responseObj[@"result"][@"list"]]);
//                  }
//                     warn:warn
//                  failure:failure
//             tokenInvalid:tokenInvalid];
//}

/**
 *  返回result下item_list 数组模型(带HUD)
 */
//+ (void)postItemListHUDWithUrl:(NSString *)url param:(id)param
//                   resultClass:(Class)resultClass
//                       success:(void (^)(id result))success
//                          warn:(void (^)(NSString *warnMsg))warn
//                       failure:(void (^)(NSError *error))failure
//                  tokenInvalid:(void (^)())tokenInvalid
//{
//    
//    [self postBaseHUDWithUrl:url param:param resultClass:resultClass
//                     success:^(id responseObj) {
//                         if (!resultClass || !responseObj[@"result"][@"list"]) {
//                             success(nil);
//                             return;
//                         }
//                         success([resultClass mj_objectArrayWithKeyValuesArray:responseObj[@"result"][@"list"]]);
//                     }
//                        warn:warn
//                     failure:failure
//                tokenInvalid:tokenInvalid];
//}

/**
 *  返回result 数据模型
 */
- (void)postResultWithUrl:(NSString *)url param:(id)param
              resultClass:(Class)resultClass
                  success:(void (^)(id result))success
                     warn:(void (^)(NSString *warnMsg))warn
                  failure:(void (^)(NSError *error))failure
             tokenInvalid:(void (^)())tokenInvalid
{
    
    [self postBaseWithUrl:url param:param resultClass:resultClass
                  success:^(id responseObj) {
                      if (!resultClass) {
                          success(nil);
                          return;
                      }
                      success([resultClass mj_objectArrayWithKeyValuesArray:responseObj[@"result"]]);
                  }
                     warn:warn
                  failure:failure
             tokenInvalid:tokenInvalid];
}

/**
 *  返回result 数据模型
 */
//+ (void)postResultHUDWithUrl:(NSString *)url param:(id)param
//                 resultClass:(Class)resultClass
//                     success:(void (^)(id result))success
//                        warn:(void (^)(NSString *warnMsg))warn
//                     failure:(void (^)(NSError *error))failure
//                tokenInvalid:(void (^)())tokenInvalid
//{
//    
//    [self postBaseHUDWithUrl:url param:param resultClass:resultClass
//                     success:^(id responseObj) {
//                         if (!resultClass) {
//                             success(nil);
//                             return;
//                         }
//                         success([resultClass mj_objectWithKeyValues:responseObj[@"result"]]);
//                     }
//                        warn:warn
//                     failure:failure
//                tokenInvalid:tokenInvalid];
//}

/**
 *  数据模型基类方法
 */
- (void)postBaseWithUrl:(NSString *)url param:(id)param
            resultClass:(Class)resultClass
                success:(void (^)(id result))success
                   warn:(void (^)(NSString *warnMsg))warn
                failure:(void (^)(NSError *error))failure
           tokenInvalid:(void (^)())tokenInvalid
{
//    url = [NSString stringWithFormat:@"%@%@",Host,url];
    CYXLog(@"\n请求链接地址---> %@",url);
    //状态栏菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    CYXHttpRequest *httpRequest = [[CYXHttpRequest alloc]init];
    
    [httpRequest post:url params:param success:^(id responseObj) {
        if (success) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil];
            CYXLog(@"请求成功，返回数据 : %@",dictData);
            success(dictData);

        }
        //状态栏菊花
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            CYXLog(@"请求失败：%@",error);
        }
        //状态栏菊花
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

/**
 *  数据模型基类(带HUD)
 */
//+ (void)postBaseHUDWithUrl:(NSString *)url param:(id)param
//               resultClass:(Class)resultClass
//                   success:(void (^)(id result))success
//                      warn:(void (^)(NSString *warnMsg))warn
//                   failure:(void (^)(NSError *error))failure
//              tokenInvalid:(void (^)())tokenInvalid
//{
//    [SVProgressHUD showWithStatus:@""];
//    [self postBaseWithUrl:url param:param resultClass:resultClass success:^(id responseObj) {
//        [SVProgressHUD dismiss];    //隐藏loading
//        success(responseObj);
//    } warn:^(NSString *warnMsg) {
//        [SVProgressHUD dismiss];
//        warn(warnMsg);
//    } failure:^(NSError *fail) {
//        [SVProgressHUD dismiss];
//        failure(fail);
//    } tokenInvalid:^{
//        [SVProgressHUD dismiss];
//        tokenInvalid();
//    }];
//}


/**
 *  组合请求参数
 *
 *  @param dict 外部参数字典
 *
 *  @return 返回组合参数
 */
+ (NSMutableDictionary *)requestParams:(NSDictionary *)dict
{
    //
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    return params;
}


@end
