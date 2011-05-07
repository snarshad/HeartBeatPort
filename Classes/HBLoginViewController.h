//
//  HBLoginViewController.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Rdio/Rdio.h>

@class HBHomeViewController;

@interface HBLoginViewController : UIViewController <RdioDelegate> {

	IBOutlet UITextField *mUsernameField;
	IBOutlet UITextField *mPasswordField;
	IBOutlet UIButton *mLoginButton;
	
	IBOutlet HBHomeViewController *mHomeViewController;
}

+ (HBLoginViewController *)sharedLoginController;

- (IBAction)login;


@end
