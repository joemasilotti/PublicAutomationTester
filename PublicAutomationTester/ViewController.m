//
//  ViewController.m
//  PublicAutomationTester
//
//  Created by pivotal on 11/19/14.
//  Copyright (c) 2014 pivotal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonWasTapped:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Title"
                                message:@"Button was tapped"
                               delegate:nil
                      cancelButtonTitle:@"Dismiss"
                      otherButtonTitles:nil] show];
}

@end
