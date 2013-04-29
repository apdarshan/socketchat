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
    // Do any additional setup after loading the view from its nib.
    self.welcomeLabel.text = [[NSString alloc]initWithFormat:@"Welcome %@,",[ViewController username]];
    
    
    socketIO = [[SocketIO alloc]initWithDelegate:self];
    [socketIO connectToHost:@"localhost" onPort:80];
    
        
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

- (IBAction)logoutAction:(id)sender
{
    [ViewController setUsername:nil];
    ViewController* vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)sendMessageAction:(id)sender
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.sendingMsgTextFeild.text forKey:@"message"];
    [dict setObject:[ViewController username] forKey:@"username"];
    
    [socketIO sendEvent:@"messagesend" withData:dict];
   
    
    NSString *fromWithMsg = [@"me: " stringByAppendingString:self.sendingMsgTextFeild.text];
    [self updateIncomingMsgSection:fromWithMsg];
    
    self.sendingMsgTextFeild.text = @"";    // Clear msgtextfield
}

-(void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"Event triggered packet: data:%@ type:%@", packet.data, packet.type);
    NSDictionary* response = [NSDictionary dictionaryWithDictionary:packet.dataAsJSON];
    
    if ([[response objectForKey:@"name"] isEqualToString:@"messagein"]) {
        
        NSString *fromUsername = [[[response objectForKey:@"args"] objectAtIndex:0] objectForKey:@"username"];
        NSString *fromColon = [fromUsername stringByAppendingString:@":  "];
        NSString *fromWithMsg = [fromColon stringByAppendingString:[[[response objectForKey:@"args"] objectAtIndex:0] objectForKey:@"msg"]];
        
        [self updateIncomingMsgSection:fromWithMsg];
    }
    
}

- (void)updateIncomingMsgSection:(NSString *)str
{    
    NSString* apendTxt = [NSString alloc];
    if (self.incomingMsgTextView.text.length == 0) {
        apendTxt = @"%@";
    }
    else{
        apendTxt = @"\n%@";
    }
    
    self.incomingMsgTextView.text = [self.incomingMsgTextView.text stringByAppendingFormat:apendTxt, str];
    
    NSRange range = NSMakeRange(self.incomingMsgTextView.text.length - 1, 1);
    [self.incomingMsgTextView scrollRangeToVisible:range];
    
}

@end
