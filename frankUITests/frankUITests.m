//
//  frankUITests.m
//  frankUITests
//
//  Created by Leonardo Formaggio on 4/11/16.
//  Copyright © 2016 Westfield. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>

#import "XCUIElement+Addons.h"
#import "XCUIElementQuery+Addons.h"

@interface frankUITests : XCTestCase

@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation frankUITests

#pragma mark - Setup

- (void)setUp {
    [super setUp];
    
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    
#if TARGET_IPHONE_SIMULATOR
    sleep(1);
#endif
}

#pragma mark - Tests

- (void)testAddPerson {
    [self.app.tabBars.buttons[@"Table"] tap];
    NSUInteger count = self.app.tables.cells.count;
    
    [self.app.navigationBars.buttons[@"Add"] tap];
    
    XCUIElement *alert = self.app.alerts.element;
    [alert.textFields.element typeText:@"John Appleseed"];
    [alert.buttons[@"OK"] tap];
    
    XCTAssertEqual(self.app.tables.cells.count, count + 1);
}

- (void)testDeleteLastPerson {
    [self.app.tabBars.buttons[@"Table"] tap];
    NSUInteger count = self.app.tables.cells.count;
    
    XCUIElement *cell = self.app.tables.cells.last;
    [self.app.tables.element scrollToElement:cell];
    [cell swipeLeft];
    [cell.buttons[@"Delete"] tap];
    
    XCTAssertEqual(self.app.tables.cells.count, count - 1);
}

- (void)testUserLocation {
    id token = [self addUIInterruptionMonitorWithDescription:@"Location Alert" handler:^BOOL(XCUIElement * _Nonnull interruptingElement) {
        if ([interruptingElement.label containsString:@"location"]) {
            [interruptingElement.buttons[@"Allow"] tap];
            return YES;
        }
        return NO;
    }];
    
    [self.app.collectionViews.cells.first tap];
    [self.app tap];
    
    [self removeUIInterruptionMonitor:token];
}

- (void)testMapLocation {
    [self.app.collectionViews.cells.first tap];
    
    XCUIElement *currentLocation = self.app.otherElements[@"Current Location"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exists == YES"];
    [self expectationForPredicate:predicate evaluatedWithObject:currentLocation handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    XCUIElement *map = self.app.maps.element;
    [map pinchWithScale:15 velocity:15];
    [currentLocation tap];
    [self.app.otherElements[@"PopoverDismissRegion"] tap];
    [map rotate:(M_PI / 4) withVelocity:(M_PI / 4)];
    [self.app.buttons[@"Compass"] tap];
    
    [self.app.navigationBars.buttons.first tap];
}

@end