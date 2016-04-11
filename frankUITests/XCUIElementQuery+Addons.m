//
//  XCUIElementQuery+Addons.m
//  uitest
//
//  Created by Leonardo Formaggio on 4/7/16.
//  Copyright © 2016 Leonardo Formaggio. All rights reserved.
//

#import "XCUIElementQuery+Addons.h"

@implementation XCUIElementQuery (Addons)

- (XCUIElement *)first {
    return self.allElementsBoundByIndex.firstObject;
}

- (XCUIElement *)last {
    return self.allElementsBoundByIndex.lastObject;
}

- (XCUIElement *)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.allElementsBoundByIndex[idx];
}

@end
