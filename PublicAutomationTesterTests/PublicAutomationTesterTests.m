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

@interface NSObject (FOO)
- (struct CGPoint)_accessibilityConvertPointToViewSpace:(struct CGPoint)arg1;
@end

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

//- (void)testTap {
//    UIATarget *target = [NSClassFromString(@"UIATarget") localTarget];
////    [target lock];
//    UIAApplication *application = [target frontMostApp];
//    NSLog(@"================> %@", [target applications]);
//    UIAWindow *window = [application mainWindow];
//    UIAButton *button = [window.buttons firstWithName:@"Button"];
//
//    NSLog(@"================> Pre tap");
////    [button tap];
////    [button performSelectorInBackground:@selector(tap) withObject:nil];
//    NSLog(@"================> Post tap");
//
//    BOOL ticking = YES;
//    while (ticking) {
//        NSLog(@"================> %@", @"inside");
//        [button performSelectorInBackground:@selector(tap) withObject:nil];
////        UIAAlert *alert = self.application.alert;
////        NSLog(@"================> %@", alert);
////        ticking = !alert.isValid;
//        NSLog(@"================> %lu", [(NSArray *)window.elements count]);
//        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
//    }
//
////    dispatch_sync(dispatch_queue_create("foo", DISPATCH_QUEUE_SERIAL), ^{
////        UIATarget *target = [NSClassFromString(@"UIATarget") localTarget];
////        UIAApplication *application = [target frontMostApp];
////        UIAWindow *window = [application mainWindow];
////
////        BOOL ticking = YES;
////        while (ticking) {
////            UIAButton *button = [window.buttons firstWithName:@"Button"];
////            [button performSelectorOnMainThread:@selector(tap) withObject:nil waitUntilDone:YES];
//////            [button tap];
////            [NSThread sleepForTimeInterval:0.1f];
////        }
////    });
//
////    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError *error) {
////        if (error) NSLog(@"================> %@", error);
////    }];
//}

//- (void)testButtonsAndAlerts {
//    UIAButton *button = [self.window.buttons firstWithName:@"Button"];
//    [self tapElement:button];
//
//    UIAAlert *alert = self.application.alert;
//    [self assertNotNilElement:alert];
//
//    [self tapElement:[alert.buttons firstWithName:@"Dismiss"]];
//    [alert waitForInvalid];
//    [self assertNilElement:self.application.alert];
//}
//
//- (void)testSegmentedControls {
//    UIASegmentedControl *control = [self.window.segmentedControls firstObject];
//    UIAButton *button = [control.buttons firstWithName:@"Second"];
//    [self tapElement:button];
//    [self assertElement:control hasValue:@"Second" forKeyPath:@"selectedButton.name"];
//}
//
//- (void)testSlider {
//    UIASlider *slider = [self.window.sliders firstObject];
//    [slider dragToValue:@"0.8"];
//}

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

- (void)testTabs {
    UIATarget *fakeTarget=[NSClassFromString(@"UIATarget") localTarget];
    UIAApplication *fmApp = [fakeTarget frontMostApp];
    UIAWindow *window = [fmApp mainWindow];
    UIATabBar *tabBar = [window tabBar];
    NSArray *array1= [tabBar buttons];
    [[array1 objectAtIndex:1] tap];
}

//- (void)testWebViews {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-perform-selector-leaks"
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    id axremotething = [[[[[[[[[[window subviews] firstObject] subviews] lastObject] subviews] firstObject] subviews] firstObject] performSelector:NSSelectorFromString(@"accessibilityContainerElements")] firstObject];
//    [axremotething performSelector:@selector(setRemoteChildrenDelegate:) withObject:self];
//#pragma clang diagnostic pop
//    
//    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0f]];
//
//    UIAScrollView *scrollView = [self.window.scrollViews firstObject];
//    UIAWebView *webView = [scrollView.elements firstObject];
//    UIALink *link = [webView.links firstObject];
//
//    NSLog(@"================> %@", link);
//    [self tapElement:link];
//
//    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5.0f]];
//}

#pragma mark - Interaction Helpers

- (void)tapElement:(UIAElement *)element {
    CGRect rect = CGRectFromString([NSString stringWithFormat:@"%@", element.rect]);
    CGRect convertedRect = CGRectFromString([NSString stringWithFormat:@"%@", element._logInfo[@"convertedRect"]]);
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    point = [element _accessibilityConvertPointToViewSpace:point];
    NSLog(@"================> %@", NSStringFromCGPoint(point));
    [self.events sendTap:point];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSLog(@"================> DOES I RESPOND TO %@", NSStringFromSelector(aSelector));
    return [super respondsToSelector:aSelector];
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
