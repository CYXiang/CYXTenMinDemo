//
//  TenMinDemoTests.m
//  TenMinDemoTests
//
//  Created by Macx on 15/9/26.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>
#import <KIF/KIFTypist.h>

@interface TenMinDemoTests : KIFTestCase

@end

@implementation TenMinDemoTests

//- (void)setUp {
//    [super setUp];
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//- (void)tearDown {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//    [super tearDown];
//}
//
//- (void)testExample {
//    // This is an example of a functional test case.
//    XCTAssert(YES, @"Pass");
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)beforeAll
{
    //键盘输入延迟
    KIFTypist.keystrokeDelay = 0.1;
}

- (void)testcase1 {
    [tester tapViewWithAccessibilityLabel:@"CYXDemo"];
    
    for (int i = 0; i < 4; i+=2) {
        [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] inTableViewWithAccessibilityIdentifier:@"tableView"];
        UIView *viewToSwipe = nil;
        UIAccessibilityElement *element = nil;
    
        [tester waitForAccessibilityElement: &element view:&viewToSwipe withIdentifier:@"collectionView" tappable:NO];
    
        [tester swipeAccessibilityElement:element inView:viewToSwipe inDirection:KIFSwipeDirectionUp];
    
//    [tester pullToRefreshViewWithAccessibilityLabel:@"Pull down to refresh" pullDownDuration:KIFPullToRefreshInAboutTwoSeconds];
    //    [tester swipeViewWithAccessibilityIdentifier:@"tableView" inDirection:KIFSwipeDirectionUp];
    
        [tester tapScreenAtPoint:CGPointMake(55, 55)];
        [tester tapStatusBar];
    }
    
    [NSThread sleepForTimeInterval:2];
    
}


- (void)testLogin {
    //    UIView *view = [tester waitForViewWithAccessibilityIdentifier:@"textField"];
    //    [tester tapViewWithAccessibilityIdentifier:@"login"];
    //    [tester tapViewWithAccessibilityIdentifier:@"tableView"];
    [tester tapViewWithAccessibilityLabel:@"博文"];

    [tester clearTextFromViewWithAccessibilityLabel:@"usename"];
    [tester enterText:@"testusename\n" intoViewWithAccessibilityLabel:@"usename"];
    [tester clearTextFromViewWithAccessibilityLabel:@"password"];
    [tester enterText:@"123445\n" intoViewWithAccessibilityLabel:@"password"];
    [tester tapViewWithAccessibilityLabel:@"login"];
    
    [tester clearTextFromViewWithAccessibilityLabel:@"usename"];
    [tester enterText:@"dingdone\n" intoViewWithAccessibilityLabel:@"usename"];
    [tester clearTextFromViewWithAccessibilityLabel:@"password"];
    [tester enterText:@"123456\n" intoViewWithAccessibilityLabel:@"password"];
    
    [tester tapViewWithAccessibilityLabel:@"ok"];
    [NSThread sleepForTimeInterval:1];
    
    [tester tapViewWithAccessibilityLabel:@"login"];
    
//    [tester swipeViewWithAccessibilityIdentifier:@"tableView" inDirection:KIFSwipeDirectionUp];
    [tester swipeViewWithAccessibilityLabel:@"tableView" inDirection:KIFSwipeDirectionUp];
    
    //点击cell
    for (int i = 0; i < 6; i+=3) {
        [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] inTableViewWithAccessibilityIdentifier:@"tableView"];
        [tester tapScreenAtPoint:CGPointMake(55, 55)];
        [tester tapStatusBar];
    }
    
    [tester tapViewWithAccessibilityLabel:@"Edit"];
    [tester tapViewWithAccessibilityLabel:@"Done"];
    [tester tapScreenAtPoint:CGPointMake(55, 55)];
    [tester tapStatusBar];
    
    //    for (int i = 0; i < 6; i+=3) {
    //        UITableView *tableView;
    //
    //        [tester waitForAccessibilityElement:NULL view:&tableView withIdentifier:@"tableView" tappable:NO];
    //
    //        [tester waitForDeleteStateForCellAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] inTableView:tableView];
    //    }
    
    [NSThread sleepForTimeInterval:2];
    
    //    [tester clearTextFromAndThenEnterText:@"textFieldcccdtudtrd\n" intoViewWithAccessibilityIdentifier:@"uname"];
    //    view = [tester waitForViewWithAccessibilityIdentifier:@"label"];
    //    view = [tester waitForViewWithAccessibilityIdentifier:@"view"];
}


@end

