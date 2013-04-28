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
//    SRWebSocket* webSocketIO;
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



-(void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet{
    
    
    NSLog(@"Event triggered packet: data:%@ type:%@", packet.data, packet.type);
    NSDictionary* response = [NSDictionary dictionaryWithDictionary:packet.dataAsJSON];

   if ([[response objectForKey:@"name"] isEqualToString:@"messagein"]) {
       
//        if ([[response objectForKey:@"name"] isEqualToString:@"task"]&&[response objectForKey:@"args"]&&[[response objectForKey:@"args"] count]>0) {
//            self.incomingMsgTextView.text = [self.incomingMsgTextView.text stringByAppendingFormat:@"\n%@",[[response objectForKey:@"args"] objectAtIndex:0]];
//        }
       
       self.incomingMsgTextView.text = [[[response objectForKey:@"args"] objectAtIndex:0] objectForKey:@"msg"];
       self.fromUserLabel.text = [[[response objectForKey:@"args"] objectAtIndex:0] objectForKey:@"username"];
       self.fromUserLabel.text = [self.fromUserLabel.text stringByAppendingFormat:@"%@", @": "];
   }

}


- (void)updateIncomingMsgSection:(NSDictionary *)args {
    self.fromUserLabel.text = [args objectForKey:@"username"];
    self.incomingMsgTextView.text  = [args objectForKey:@"msg"];
}


- (void) socketIO:(SocketIO *)socket failedToConnectWithError:(NSError *)error
{
    NSLog(@"failedToConnectWithError() %@", error);
}


- (IBAction)logoutAction:(id)sender {
    [ViewController setUsername:nil];
    ViewController* vc = [[ViewController alloc]init];
    //[self parentViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)sendMessageAction:(id)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.sendingMsgTextFeild.text forKey:@"message"];
    [dict setObject:[ViewController username] forKey:@"username"];
    
    [socketIO sendEvent:@"messagesend" withData:dict];
    self.sendingMsgTextFeild.text = @"";
    
}

@end
