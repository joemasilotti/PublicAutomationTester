//
//  ViewController.m
//  PublicAutomationTester
//
//  Created by Joe Masilotti on 11/19/14.
//  Copyright (c) 2014 Masilotti.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44.0f, self.view.bounds.size.width, 300.0f) configuration:configuration];
    [webView loadHTMLString:@"<html><body><a href='http://google.com'>GOOGLE</a></body></html>" baseURL:nil];
    [self.view addSubview:webView];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 44.0f)];
    [button setTitle:@"BUTTON" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonWasTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 500, 200, 22.0f)];
    [self.view addSubview:slider];
}

- (void)buttonWasTapped {
    [[[UIAlertView alloc] initWithTitle:@"Button Tapped" message:@"" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
}

@end
