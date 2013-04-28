//
//  mainViewController.h
//  crosschat3
//
//  Created by Darshan A Prakash on 28/04/13.
//  Copyright (c) 2013 Akashy Iyengar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
- (IBAction)logoutAction:(id)sender;

@end
