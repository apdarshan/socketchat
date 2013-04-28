//
//  ViewController.h
//  crosschat3
//
//  Created by Darshan A Prakash on 28/04/13.
//  Copyright (c) 2013 Akashy Iyengar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *yourNameTextField;
- (IBAction)joinBtnAction:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;

+ (NSString *)username;
+ (void)setUsername:(NSString *)usernamevalue;

@end
