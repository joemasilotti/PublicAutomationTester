//
//  PublicAutomationTesterTests.m
//  PublicAutomationTesterTests
//
//  Created by pivotal on 11/19/14.
//  Copyright (c) 2014 pivotal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <PublicAutomation/UIAutomation.h>

@interface PublicAutomationTesterTests : XCTestCase
@property (nonatomic, strong) UIAApplication *application;
@property (nonatomic, strong) UIAWindow *window;
@property (nonatomic, strong) UIASyntheticEvents *events;
@end

@implementation PublicAutomationTesterTests

- (void)setUp {
    UIATarget *target = [NSClassFromString(@"UIATarget") localTarget];
    self.application = [target frontMostApp];
    self.window = [self.application mainWindow];
    self.events = [NSClassFromString(@"UIASyntheticEvents") sharedEventGenerator];
}

#pragma mark - Tests

- (void)testButtonsAndAlerts {
    UIAButton *button = [self.window.buttons firstWithName:@"Button"];
    [self tapElement:button];

    UIAAlert *alert = self.application.alert;
    [self assertNotNilElement:alert];

    [self tapElement:[alert.buttons firstWithName:@"Dismiss"]];
    [alert waitForInvalid];
    [self assertNilElement:self.application.alert];
}

- (void)testSegmentedControls {
    UIASegmentedControl *control = [self.window.segmentedControls firstObject];
    UIAButton *button = [control.buttons firstWithName:@"Second"];
    [self tapElement:button];
    [self assertElement:control hasValue:@"Second" forKeyPath:@"selectedButton.name"];
}

- (void)testSlider {
    UIASlider *slider = [self.window.sliders firstObject];
    [slider dragToValue:@"8"];
}

//- (void)testTap {
//    dispatch_async(dispatch_queue_create("foo", DISPATCH_QUEUE_SERIAL), ^{
//        UIATarget *target = [NSClassFromString(@"UIATarget") localTarget];
//        UIAApplication *application = [target frontMostApp];
//        UIAWindow *window = [application mainWindow];
////        UIASyntheticEvents *events = [NSClassFromString(@"UIASyntheticEvents") sharedEventGenerator];
//        UIAButton *button = [window.buttons firstWithName:@"Button"];
//        [button tap];
//    });
//
//    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10.0f]];
//}

#pragma mark - Interaction Helpers

- (void)tapElement:(UIAElement *)element {
    CGRect rect = CGRectFromString([NSString stringWithFormat:@"%@", element.rect]);
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [self.events sendTap:point];
}

#pragma mark - Assertion Helpers

- (void)assertNilElement:(UIAElement *)element {
    XCTAssertTrue([element isKindOfClass:[NSClassFromString(@"UIAElementNil") class]]);
}

- (void)assertNotNilElement:(UIAElement *)element {
    XCTAssertFalse([element isKindOfClass:[NSClassFromString(@"UIAElementNil") class]]);
}

- (void)assertElement:(UIAElement *)element hasValue:(NSString *)value forKeyPath:(NSString *)keyPath {
    BOOL ticking = YES;
    while (ticking) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate date]];
        ticking = ![[element valueForKeyPath:keyPath] isEqualToString:value];
    }
    XCTAssertTrue([[element valueForKeyPath:keyPath] isEqualToString:value]);
}

@end
