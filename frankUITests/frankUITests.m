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
@property (nonatomic, strong) NSMutableSet *tokens;

@end

@implementation frankUITests

#pragma mark - Tests

- (void)testMapLocation {
    [self.app.collectionViews.cells.first tap];
    
    XCUIElement *map = self.app.maps.element;
    if (!map.exists) {
        [self.app tap];
    }
    
    XCUIElement *currentLocation = self.app.otherElements[@"Current Location"];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(XCUIElement *obj, NSDictionary *bindings) {
        return obj.exists && obj.centerCoordinate.screenPoint.x == map.centerCoordinate.screenPoint.x;
    }];
    [self expectationForPredicate:predicate evaluatedWithObject:currentLocation handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    [map pinchWithScale:15 velocity:15];
    [currentLocation tap];
    [self.app.otherElements[@"PopoverDismissRegion"] tap];
    [map rotate:(M_PI / 4) withVelocity:(M_PI / 4)];
    [self.app.buttons[@"Compass"] tap];
    
    [self.app.navigationBars.buttons.first tap];
}

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

#pragma mark - Setup

- (void)setUp {
    [super setUp];
    
    self.tokens = [[NSMutableSet alloc] init];
    [self addLocationInterruptionMonitor];
    
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    
#if TARGET_IPHONE_SIMULATOR
    sleep(1);
#endif
}

- (void)tearDown {
    for (id token in self.tokens) {
        [self removeUIInterruptionMonitor:token];
    }
    
    [super tearDown];
}

#pragma mark - Instance Methods

- (void)addLocationInterruptionMonitor {
    id token = [self addUIInterruptionMonitorWithDescription:@"Location Alert" handler:^BOOL(XCUIElement * _Nonnull interruptingElement) {
        if ([interruptingElement.label containsString:@"location"]) {
            [interruptingElement.buttons[@"Allow"] tap];
            return YES;
        }
        return NO;
    }];
    [self.tokens addObject:token];
}

@end