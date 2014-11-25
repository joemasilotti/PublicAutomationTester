//
//  AppDelegate.m
//  PublicAutomationTester
//
//  Created by Joe Masilotti on 11/19/14.
//  Copyright (c) 2014 Masilotti.com. All rights reserved.
//

#import "AppDelegate.h"
#import <PublicAutomation/UIAutomationBridge.h>
#import <PublicAutomation/UIAutomation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UIATarget *target = [UIAutomationBridge uiat];
    UIAWindow *window = [target.frontMostApp mainWindow];

    UIAWebView *webView = [[[window.scrollViews firstObject] webViews] firstObject];
    UIALink *link = [webView.links firstObject];
    NSString *linkExpression = [link scriptingSynonymFullExpressionString];
    NSString *script = [NSString stringWithFormat:@"%@.%@", linkExpression, @"tap()"];

    [[NSUserDefaults standardUserDefaults] setObject:script forKey:@"script"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:2.5f];
}

- (void)stop {
    [[NSUserDefaults standardUserDefaults] setObject:@"keepGoing = false;" forKey:@"script"];
}

- (void)tapElement:(UIAElement *)element {
    CGRect rect = CGRectFromString([NSString stringWithFormat:@"%@", element.rect]);
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [[UIAutomationBridge uia] sendTap:point];
}

@end
