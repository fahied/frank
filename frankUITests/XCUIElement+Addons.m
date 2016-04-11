//
//  XCUIElement+Addons.m
//  uitest
//
//  Created by Leonardo Formaggio on 4/7/16.
//  Copyright © 2016 Leonardo Formaggio. All rights reserved.
//

#import "XCUIElement+Addons.h"
#import "XCUIElementQuery+Addons.h"

@implementation XCUIElement (Addons)

- (BOOL)isVisible {
    return self.exists && self.isHittable;
}

- (void)scrollToElement:(XCUIElement *)element {
    while (!element.isVisible) {
        if (CGRectGetMinY(element.frame) > CGRectGetMaxY(self.frame)) {
            [self swipeUp];
        } else if (CGRectGetMaxY(element.frame) < CGRectGetMinY(self.frame)) {
            [self swipeDown];
        } else if (CGRectGetMinX(element.frame) > CGRectGetMaxX(self.frame)) {
            [self swipeLeft];
        } else if (CGRectGetMaxX(element.frame) < CGRectGetMinX(self.frame)) {
            [self swipeRight];
        } else {
            break;
        }
    }
}

- (XCUICoordinate *)originCoordinate {
    return [self coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
}

- (XCUICoordinate *)centerCoordinate {
    return [self coordinateWithNormalizedOffset:CGVectorMake(0.5, 0.5)];
}

@end
