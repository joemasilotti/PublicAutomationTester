//
//  ViewController.m
//  PublicAutomationTester
//
//  Created by pivotal on 11/19/14.
//  Copyright (c) 2014 pivotal. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *uiWebView;
@property (nonatomic, weak) WKWebView *wkWebView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.uiWebView loadHTMLString:@"<html><body><h1>UIWebView</h1></body></html>"
                           baseURL:nil];

    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(200, 100, 100, 100) configuration:conf];
    [webView loadHTMLString:@"<html><body><a id='theawesomelink' href='thepete.net'>WKWebView</a></body></html>"
                    baseURL:nil];
    [self.view addSubview:webView];
}

- (IBAction)buttonWasTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Button"
                                message:nil //[[NSThread currentThread] description]
                               delegate:nil
                      cancelButtonTitle:@"Dismiss"
                      otherButtonTitles:nil] show];
}

@end
