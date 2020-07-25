//
//  _00__HelloOpenGLESUITests.m
//  000--HelloOpenGLESUITests
//
//  Created by CC老师 on 2019/5/25.
//  Copyright © 2019年 CC老师. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface _00__HelloOpenGLESUITests : XCTestCase

@end

@implementation _00__HelloOpenGLESUITests

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
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
