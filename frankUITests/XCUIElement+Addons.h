//
//  XCUIElement+Addons.h
//  uitest
//
//  Created by Leonardo Formaggio on 4/7/16.
//  Copyright © 2016 Leonardo Formaggio. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCUIElement (Addons)

@property (nonatomic, readonly, getter=isVisible) BOOL visible;

- (void)scrollToElement:(XCUIElement *)element;
- (XCUICoordinate *)originCoordinate;
- (XCUICoordinate *)centerCoordinate;

@end
