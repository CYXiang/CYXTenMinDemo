##前言
>在[十分钟搭建主流框架_简单的网络部分(OC)
   ](http://www.jianshu.com/p/6eb7eabda386)中，我们使用AFN框架顺利的发送网络请求并返回了有用数据，但对AFN框架的依赖十分严重，下面我们重构一下。
######[源码github地址](https://github.com/CYXiang/CYXTenMinDemo)

---

##初步
- 很多时候，我们涉及到网络请求这块，都离不开几个第三方框架，`AFNetworking`，`MJExtention`, `MBProgressHUD（SV）`。
- 初学的时候，都会把它们写到Controller里面，如下:
```
[[AFHTTPSessionManager manager] GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
NSLog(@"请求成功");

// 利用MJExtension框架进行字典转模型
weakSelf.menus = [CYXMenu objectArrayWithKeyValuesArray:responseObject[@"result"]];

// 刷新数据（若不刷新数据会显示不出）
[weakSelf.tableView reloadData];

} failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
NSLog(@"请求失败 原因：%@",error);
}];
```
- 这样会造成耦合性过高的问题，灵活性也非常不好，因此，AFN的作者也推荐我们不要直接使用，新建一个网络请求类来继承AFN的使用方式更好。
- 因此，继承的方式，如下：

- CYXHTTPSessionManager.h文件

```
#import <AFHTTPSessionManager.h>
@interface CYXHTTPSessionManager : AFHTTPSessionManager
@end
```
- CYXHTTPSessionManager.m文件

```
#import "CYXHTTPSessionManager.h"
@implementation CYXHTTPSessionManager
+ (instancetype)manager{
CYXHTTPSessionManager *mgr = [super manager];
//    这里可以做一些统一的配置
//    mgr.responseSerializer = ;
//    mgr.requestSerializer = ;
return mgr;
}
@end
```
- 调用方式：

```
/** 请求管理者 */
@property (nonatomic,weak) CYXHTTPSessionManager * manager;

// 发送请求
[self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
// 存储 maxtime
weakSelf.maxtime = responseObject[@"info"][@"maxtime"];

weakSelf.topics =  [CYXTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
CYXLog(@"%@",responseObject[@"list"]);
[weakSelf.tableView reloadData];

// 结束刷新
[weakSelf.tableView.header endRefreshing];

} failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
[weakSelf.tableView.header endRefreshing];
}];
```
- 这样，已经降低了一点耦合度，也不需要在每个需要发送网络请求的Controller中引入AFN框架了。但对于MJExtension框架的依赖还是没有改善。

##进阶
- 通过观察，我们发现其实大部分的GET和POST请求的前几步基本使用步骤是大致相同的，相同的步骤如下：
- 1.通过AFN请求回来JSON数据
- 2.通过JSON数据，取出需要使用的字典数组/字典
- 3.使用字典转模型框架（MJExtension）把字典数组转化为模型数组/字典转化为模型

- 因此，我们思考能不能把这些相同的步骤封装起来，以后就不需要重复写这些代码了，我们都知道一条经典的编程法则：“Don't repeat youself”。这就是我们封装与重构的理由！


---
###1.基层请求的封装
- 本文示例封装POST请求
- CYXHttpRequest.h文件

```
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface CYXHttpRequest : NSObject

/**
*  发送一个POST请求
*
*  @param url     请求路径
*  @param params  请求参数
*  @param success 请求成功后的回调
*  @param failure 请求失败后的回调
*/
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
```
- CYXHttpRequest.m文件

```
#import "CYXHttpRequest.h"
@implementation CYXHttpRequest
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
// 1.获得请求管理者
AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
// 2.申明返回的结果是text/html类型
mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
// 3.设置超时时间为10s
mgr.requestSerializer.timeoutInterval = 10;
// 4.发送POST请求
[mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
if (success) {
success(responseObject);
}
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
if (failure) {
failure(error);
}
}];
}

@end
```
- 现在已经可以把网络数据请求回来了，轮到第二个步骤了：观察请求回来的JSON数据，取出需要使用的字典数组/字典。在这里再作一层封装。举个简单的例子,假如返回的JSON数据结构如下:

```
{
"error_code": 0,
"reason": "Success",
"result": [{
"id": 370622,
"title": "西红柿蒜薹炒鸡蛋",
"tags": "厨房用具;厨具;加工工艺;基本工艺;菜品;菜肴;家常菜;炒;炒锅;热菜;防辐射;开胃;蔬菜类;果实类;蒜薹;西红柿;禽蛋类;蛋;鸡蛋;",
"intro": "我这的蒜薹鸡蛋都爱加西红柿、辣椒一起炒的，这是习惯所致，爱吃西红柿，爱吃辣椒，还爱把菜搭配的颜色亮丽，当然味道也不差。",
"ingredients": "西红柿:1个;蒜薹:200g;鸡蛋:2个;",
"burden": "油:适量;盐:适量;青辣椒:1个;红辣椒:1个;",
"albums": "http://imgs.haoservice.com/CaiPu/pic/recipe/l/be/a7/370622_86e12b.jpg",
}
{
"id": 433079,
"title": "西红柿酸奶",
"tags": "促进食欲;减肥;懒人食谱;消暑食谱;美容养颜;",
"intro": "新疆人爱吃西红柿那是有目共睹的，菜里面加西红柿的数不胜数，就连舌尖2在吐鲁番拍的葡萄干抓饭里面都加西红柿。",
"ingredients": "酸奶:400g;西红柿:200g;",
"burden": "白糖:20g;",
"albums": "http://imgs.haoservice.com/CaiPu/pic/recipe/l/b7/9b/433079_377373.jpg",
}
{···}]
}
```
###2.简单业务逻辑封装
- 现在只需要使用到`result`数据（并对应`CYXMenu`模型），在公司中，接口一般会有比较好的规范，即每个接口的模型属性一般都有统一的命名。
- 我们使用时，通常会把`result`字典数组转化成`CYXMenu `模型数组。因此，可以进一步的封装出`CYXBaseRequest`对象。
- `CYXBaseRequest`类实现思路如下：
- 1.使用`CYXHttpRequest `发起网络请求，返回数据中取到`result`
- 2.使用`MJExtension`将`result`字典数组转化成`CYXMenu `模型数组，并返回模型数组
- 3.外界只需要传递进来一个`resultClass`即可。
- CYXBaseRequest实现代码如下：
- CYXBaseRequest.h文件

```
#import <Foundation/Foundation.h>

@interface CYXBaseRequest : NSObject

/**
*  返回result 数据模型
*
*  @param url          请求地址
*  @param param        请求参数
*  @param resultClass  需要转换返回的数据模型
*  @param success      请求成功后的回调
*  @param warn         请求失败后警告提示语
*  @param failure      请求失败后的回调
*  @param tokenInvalid token过期后的回调
*/
+ (void)postResultWithUrl:(NSString *)url param:(id)param
resultClass:(Class)resultClass
success:(void (^)(id result))success
warn:(void (^)(NSString *warnMsg))warn
failure:(void (^)(NSError *error))failure
tokenInvalid:(void (^)())tokenInvalid;

/**
*  返回result 数据模型（带HUD）
*
*  @param url          请求地址
*  @param param        请求参数
*  @param resultClass  需要转换返回的数据模型
*  @param success      请求成功后的回调
*  @param warn         请求失败后警告提示语
*  @param failure      请求失败后的回调
*  @param tokenInvalid token过期后的回调
*/
+ (void)postResultHUDWithUrl:(NSString *)url param:(id)param
resultClass:(Class)resultClass
success:(void (^)(id result))success
warn:(void (^)(NSString *warnMsg))warn
failure:(void (^)(NSError *error))failure
tokenInvalid:(void (^)())tokenInvalid;

/**
*  组合请求参数
*
*  @param dict 外部参数字典
*
*  @return 返回组合参数
*/
+ (NSMutableDictionary *)requestParams:(NSDictionary *)dict;

@end

```

- CYXBaseRequest.m文件

```
#import "CYXBaseRequest.h"
#import "CYXHttpRequest.h"
#import "ExceptionMsgTips.h"
#import "MJExtension.h"

@implementation BSBaseRequest

/**
*  返回result 数据模型（HUD）
*/
+ (void)postResultHUDWithUrl:(NSString *)url param:(id)param
resultClass:(Class)resultClass
success:(void (^)(id result))success
warn:(void (^)(NSString *warnMsg))warn
failure:(void (^)(NSError *error))failure
tokenInvalid:(void (^)())tokenInvalid
{

[self postBaseHUDWithUrl:url param:param resultClass:resultClass
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
+ (void)postResultWithUrl:(NSString *)url param:(id)param
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
*  数据模型基类方法
*/
+ (void)postBaseWithUrl:(NSString *)url param:(id)param
resultClass:(Class)resultClass
success:(void (^)(id result))success
warn:(void (^)(NSString *warnMsg))warn
failure:(void (^)(NSError *error))failure
tokenInvalid:(void (^)())tokenInvalid
{
//    url = [NSString stringWithFormat:@"%@%@",Host,url];
CYXLog(@"\\n请求链接地址---> %@",url);
//状态栏菊花
[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
[CYXHttpRequest post:url params:param success:^(id responseObj) {
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
+ (void)postBaseHUDWithUrl:(NSString *)url param:(id)param
resultClass:(Class)resultClass
success:(void (^)(id result))success
warn:(void (^)(NSString *warnMsg))warn
failure:(void (^)(NSError *error))failure
tokenInvalid:(void (^)())tokenInvalid
{
[SVProgressHUD showWithStatus:@""];
[self postBaseWithUrl:url param:param resultClass:resultClass success:^(id responseObj) {
[SVProgressHUD dismiss];    //隐藏loading
success(responseObj);
} warn:^(NSString *warnMsg) {
[SVProgressHUD dismiss];
warn(warnMsg);
} failure:^(NSError *fail) {
[SVProgressHUD dismiss];
failure(fail);
} tokenInvalid:^{
[SVProgressHUD dismiss];
tokenInvalid();
}];
}
@end
```

- 到这里，轻量级的封装介绍已经全部介绍完了，更多的功能封装有待读者自己去研究了。既然封装好了，下面我们来介绍一下如何使用，其实非常简单。

###使用介绍
- 1.把上述两个类的.h  .m 文化拖到您项目中，最好新建一个<Request>文件夹。
- 2.在需要发送请求的Controller中`#import "CYXBaseRequest.h"`
- 3.发送请求方法中的代码如下：
- （使用CYXBaseRequest）：

```
#pragma mark - 请求数据方法
- (void)loadData{
self.pn = 1;
// 请求参数（根据接口文档编写）
NSMutableDictionary *params = [NSMutableDictionary dictionary];
params[@"menu"] = @"西红柿";
params[@"pn"] = @(self.pn);
params[@"rn"] = @"10";
params[@"key"] = @"fcfdb87c50c1485e9e7fa9f839c4b1a8";
[CYXBaseRequest postResultWithUrl:CYXRequestURL param:params resultClass:[CYXMenu class] success:^(id result) {
CYXLog(@"请求成功，返回数据 : %@",result);
self.menus = result;
self.pn ++;
// 刷新数据（若不刷新数据会显示不出）
[self.tableView reloadData];
[self.tableView.mj_header endRefreshing];
} warn:^(NSString *warnMsg) {

} failure:^(NSError *error) {
CYXLog(@"请求失败 原因：%@",error);
[self.tableView.mj_header endRefreshing];
} tokenInvalid:^{
// 有登录操作的业务，这里返回登录状态
}];
}
```

- 在这里对比一下不使用CYXBaseRequest的发送请求方法代码：

```
#pragma mark - 请求数据方法
- (void)loadData{
self.pn = 1;
// 请求参数（根据接口文档编写）
NSMutableDictionary *params = [NSMutableDictionary dictionary];
params[@"menu"] = @"西红柿";
params[@"pn"] = @(self.pn);
params[@"rn"] = @"10";
params[@"key"] = @"fcfdb87c50c1485e9e7fa9f839c4b1a8";    
[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
[self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
[self.manager POST:CYXRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
CYXLog(@"请求成功，返回数据 : %@",responseObject);
// 利用MJExtension框架进行字典转模型
weakSelf.menus = [CYXMenu  mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
weakSelf.pn ++;
// 刷新数据（若不刷新数据会显示不出）
[weakSelf.tableView reloadData];
[weakSelf.tableView.mj_header endRefreshing];
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
CYXLog(@"请求失败 原因：%@",error);
[weakSelf.tableView.mj_header endRefreshing];
}];
}

```
- 虽然从代码看似两种使用差别不太大（只是少了几行代码），但相比之下，前者确实降低了对AFN等框架的依赖，并省去了每次都手动转一下模型的烦恼，现在你只需要把`resultClass `传过去，返回的数据便是已经转化好的模型，并在`CYXBaseRequest`内打印出`请求链接地址`，`返回数据`等有用信息，方便调试，接口设计也类似AFN，使用简便。

---

- TIPS:建议使用者可以在每个模块都建立Request文件（继承CYXBaseRequest），统一进行网络请求，这样更方便管理。

####注：
- 本封装实践只对网络请求进行初步的简单封装，仅适用于中小型的项目，并不涉及缓存、校验等高级功能，如果有高级需求，建议研究下猿题库的YTKNetwork网络库。


- 附：[源码github地址](https://github.com/CYXiang/CYXTenMinDemo)