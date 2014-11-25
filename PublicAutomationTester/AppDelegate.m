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
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"in"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"out"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UIATarget *target = [UIAutomationBridge uiat];
    UIAWindow *window = [target.frontMostApp mainWindow];

    UIAWebView *webView = [[[window.scrollViews firstObject] webViews] firstObject];
    UIALink *link = [webView.links firstObject];
    NSString *linkExpression = [link scriptingSynonymFullExpressionString];

    NSString *script = [NSString stringWithFormat:@"%@.%@", linkExpression, @"url()"];
    NSString *output = [self runScript:script];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = output;
    [self.window addSubview:label];
    
//    [self performSelector:@selector(stop) withObject:nil afterDelay:2.5f];
}

- (NSString *)runScript:(NSString *)script {
    [[NSUserDefaults standardUserDefaults] setObject:script forKey:@"in"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSInteger ticker = 0;
    while ([[[NSUserDefaults standardUserDefaults] objectForKey:@"out"] isEqualToString:@""] &&
           ticker < 100) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
        ticker++;
    }

    NSString *output = [[NSUserDefaults standardUserDefaults] objectForKey:@"out"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"out"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return output;
}

- (void)stop {
    [[NSUserDefaults standardUserDefaults] setObject:@"keepGoing = false;" forKey:@"in"];
}

- (void)tapElement:(UIAElement *)element {
    CGRect rect = CGRectFromString([NSString stringWithFormat:@"%@", element.rect]);
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [[UIAutomationBridge uia] sendTap:point];
}

@end
