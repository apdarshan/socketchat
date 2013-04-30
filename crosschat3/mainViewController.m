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
{
    SocketIO* socketIO;
}
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
        
    //get username from previous view controller and update welcome text
    self.welcomeLabel.text = [[NSString alloc]initWithFormat:@"Welcome %@,",[ViewController username]];
    
    //initialize socket connection with the nodeJS chat server running on http://nodejitsu.com
    socketIO = [[SocketIO alloc]initWithDelegate:self];
    [socketIO connectToHost:@"crosschat.nodejitsu.com" onPort:80];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) socketIO:(SocketIO *)socket failedToConnectWithError:(NSError *)error
{
    NSLog(@"failedToConnectWithError() %@", error);
}


//on logout link click
- (IBAction)logoutAction:(id)sender
{
    // unset username of previous controller and redirect to previous controller
    [ViewController setUsername:nil];
    ViewController* vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

//to hide keypad when done typing
- (IBAction)textFieldDoneEditing:(id)sender
{
    //hide keypad on clicking of done button
    [sender resignFirstResponder];
}


// to send new message
- (IBAction)sendMessageAction:(id)sender
{
    //get username and message. create dictionary object
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.sendingMsgTextFeild.text forKey:@"message"];
    [dict setObject:[ViewController username] forKey:@"username"];
    
    // send event with message(eventname: messagesend) using socketIO
    [socketIO sendEvent:@"messagesend" withData:dict];
   
    //update chat messages area with his message
    NSString *fromWithMsg = [@"me: " stringByAppendingString:self.sendingMsgTextFeild.text];
    [self updateIncomingMsgSection:fromWithMsg];
    
    self.sendingMsgTextFeild.text = @"";    // Clear msgtextfield
}


// to handle incoming message
-(void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"Event triggered packet: data:%@ type:%@", packet.data, packet.type);
    
    // get json message and convert it to dictionary object 
    NSDictionary* response = [NSDictionary dictionaryWithDictionary:packet.dataAsJSON];
    
    // interested only on messagein event
    if ([[response objectForKey:@"name"] isEqualToString:@"messagein"]) {
        
        //get sender's username and append it with a colon to display
        NSString *fromUsername = [[[response objectForKey:@"args"] objectAtIndex:0] objectForKey:@"username"];
        NSString *fromColon = [fromUsername stringByAppendingString:@":  "];
        
        // get sender's message text and append with sender's name
        NSString *fromWithMsg = [fromColon stringByAppendingString:[[[response objectForKey:@"args"] objectAtIndex:0] objectForKey:@"msg"]];
        
        // update message's area
        [self updateIncomingMsgSection:fromWithMsg];
    }    
}


//to update messages area
- (void)updateIncomingMsgSection:(NSString *)str
{
    //to give line feed for every message coming except first message
    NSString* apendTxt = [NSString alloc];
    if (self.incomingMsgTextView.text.length == 0) {
        apendTxt = @"%@";
    }
    else{
        apendTxt = @"\n%@";
    }
    
    // update messages area
    self.incomingMsgTextView.text = [self.incomingMsgTextView.text stringByAppendingFormat:apendTxt, str];
    
    //scroll bottom to make recent message visible
    NSRange range = NSMakeRange(self.incomingMsgTextView.text.length - 1, 1);
    [self.incomingMsgTextView scrollRangeToVisible:range];
}

@end
