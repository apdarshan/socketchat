//
//  mainViewController.h
//  crosschat3
//
//  Created by Darshan A Prakash on 28/04/13.
//  Copyright (c) 2013 Akashy Iyengar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
//#import "SRWebSocket.h"
#import "SocketIOPacket.h"

@interface mainViewController : UIViewController<SocketIODelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *fromUserLabel;
@property (weak, nonatomic) IBOutlet UITextView *incomingMsgTextView;
@property (weak, nonatomic) IBOutlet UITextField *sendingMsgTextFeild;

- (IBAction)logoutAction:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)sendMessageAction:(id)sender;
- (void)updateIncomingMsgSection:(NSString *)str;

@end
