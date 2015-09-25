//
//  CYXDragViewController.m
//  抽屉效果
//
//  Created by Macx on 14/8/18.
//  Copyright (c) 2014年 CYX. All rights reserved.
//

#import "CYXDragViewController.h"

#define screenW [UIScreen mainScreen].bounds.size.width


@interface CYXDragViewController ()

@end

@implementation CYXDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.添加子控件
    [self setUpChildView];
    
    //2.添加手势
    [self setUpGestureRecognizer];
    
    //3.监听mainView.frame的改变
    [self setUpKVO];
    
    
}

- (void)setUpKVO{
    //添加观察者
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

//添加手势
- (void)setUpGestureRecognizer{
    //给mainView添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.mainView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    
    [self.view addGestureRecognizer:tap];
    
}

#define rigthTargetX 300
#define leftTargetX -250


//手势方法
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGFloat offSetX = [pan translationInView:self.mainView].x;
    
    _mainView.frame = [self frameWithOffsetX:offSetX];
    
    //复位
    [pan setTranslation:CGPointZero inView:_mainView];
    
    //手指抬起的时候定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat targat = 0;
        if (_mainView.frame.origin.x > screenW * 0.5) {
            //移动到右边
            targat = rigthTargetX;
        }else if(CGRectGetMaxX(_mainView.frame) < screenW * 0.5){
            //左移
            targat = leftTargetX;
        }
        CGFloat offsetX = targat - _mainView.frame.origin.x;
        
        [UIView animateWithDuration:0.5 animations:^{
            _mainView.frame = [self frameWithOffsetX:offsetX];
        }];
        
    }
}

- (void)tap{
    if (_mainView.frame.origin.x != 0) {
        [UIView animateWithDuration:0.25 animations:^{
            _mainView.frame = self.view.bounds;
        }];
    }
}

#define maxY 100

- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGRect frame = _mainView.frame;
    
    CGFloat x = frame.origin.x += offsetX;
    
    CGFloat y = fabs(x / screenW * maxY);
    
    CGFloat h = screenH - 2 * y;
    
    CGFloat scale = h / screenH;
    
    CGFloat w = screenW * scale;
    
    return CGRectMake(x, y, w, h);
}

//观察者监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (self.mainView.frame.origin.x > 0) {
        self.rightView.hidden = YES;
    }else if(self.mainView.frame.origin.x < 0){
        self.rightView.hidden = NO;
    }
    
}


//抽取添加所有子控件方法
- (void)setUpChildView{
    UIView *leftV = [[UIView alloc]initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor greenColor];
    _leftView = leftV;
    [self.view addSubview:leftV];
    
    UIView *rightV = [[UIView alloc]initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor blueColor];
    _rightView = rightV;
    [self.view addSubview:rightV];
    
    UIView *mainV = [[UIView alloc]initWithFrame:self.view.bounds];
    mainV.backgroundColor = [UIColor redColor];
    _mainView = mainV;
    [self.view addSubview:mainV];
    
}


@end
