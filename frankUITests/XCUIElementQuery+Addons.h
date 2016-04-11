//
//  XCUIElementQuery+Addons.h
//  uitest
//
//  Created by Leonardo Formaggio on 4/7/16.
//  Copyright © 2016 Leonardo Formaggio. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUIElementQuery (Addons)

@property (nonatomic, strong, readonly) XCUIElement *first;
@property (nonatomic, strong, readonly) XCUIElement *last;

- (XCUIElement *)objectAtIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
