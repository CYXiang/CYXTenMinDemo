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
    
    //    for (int i = 0; i < 4; i+=2) {
    [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] inTableViewWithAccessibilityIdentifier:@"tableView"];
    UIView *viewToSwipe = nil;
    UIAccessibilityElement *element = nil;
    
    [tester waitForAccessibilityElement: &element view:&viewToSwipe withIdentifier:@"collectionView"  tappable:NO];
    
    [tester swipeAccessibilityElement:element inView:viewToSwipe inDirection:KIFSwipeDirectionUp];
    //    [tester swipeViewWithAccessibilityIdentifier:@"tableView" inDirection:KIFSwipeDirectionUp];
    
    [tester tapScreenAtPoint:CGPointMake(55, 55)];
    [tester tapStatusBar];
    //    }
    
    [NSThread sleepForTimeInterval:2];
    
}

@end

