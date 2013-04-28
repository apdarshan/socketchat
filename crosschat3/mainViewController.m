//
//  mainViewController.m
//  crosschat3
//
//  Created by Darshan A Prakash on 28/04/13.
//  Copyright (c) 2013 Akashy Iyengar. All rights reserved.
//

#import "mainViewController.h"
#import "viewController.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.welcomeLabel.text = [[NSString alloc]initWithFormat:@"Welcome %@,",[ViewController username]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutAction:(id)sender {
    [ViewController setUsername:nil];
    ViewController* vc = [[ViewController alloc]init];
    //[self parentViewController];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
