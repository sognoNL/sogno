//
//  HappyDelUITests.m
//  HappyDelUITests
//
//  Created by 吴孟钦 on 16/3/25.
//  Copyright © 2016年 NL. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HappyDelUITests : XCTestCase

@end

@implementation HappyDelUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testExample {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"添  加"] tap];
    [[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0] tap];
    // Use recording to get started writing UI tests.
    
    XCUIElement *button = app.buttons[@"返   回"];
    [button tap];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCUIElement *button2 = [[tabBarsQuery childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1];
    [button2 tap];
    
    XCUIElement *button3 = [[tabBarsQuery childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:2];
    [button3 tap];
    [button2 tap];
    
    XCUIElement *button4 = [[tabBarsQuery childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
    [button4 tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"1/278650"] swipeUp];
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
