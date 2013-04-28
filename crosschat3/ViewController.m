//
//  ViewController.m
//  crosschat3
//
//  Created by Darshan A Prakash on 28/04/13.
//  Copyright (c) 2013 Akashy Iyengar. All rights reserved.
//

#import "ViewController.h"
#import "mainViewController.h"


@interface ViewController ()

@end

@implementation ViewController
static NSString *username;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinBtnAction:(id)sender {
    NSString* nameString = self.yourNameTextField.text;
    
    if([nameString length]==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Your Name" message:@"Please enter your name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else{
        
        NSString* fullText = [[NSString alloc] initWithFormat:@"Good job , %@ !", nameString];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:fullText message:@"Now you joined The Room! Start Chating !" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        //        static NSString *myInstance = nil;
        //        myInstance  = [[[self class] alloc] init];
        
        username = nameString;
        mainViewController * mc = [[mainViewController alloc]init];
        [self presentViewController:mc
                           animated:YES completion:nil];
        [alert show];
    }
}

+ (NSString *)username { return username; }
+ (void)setUsername:(NSString *)usernamevalue { username = usernamevalue; }

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.yourNameTextField resignFirstResponder];
}

@end
