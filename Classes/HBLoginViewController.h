//
//  HBLoginViewController.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Rdio/Rdio.h>
#import "HBServiceProtocol.h"
#import "HBMatcherProtocol.h"

@class HBHomeViewController;

@interface HBLoginViewController : UIViewController <RdioDelegate, HBServiceLoginDelegate> {

	IBOutlet UITextField *mUsernameField;
	IBOutlet UITextField *mPasswordField;
	IBOutlet UIButton *mLoginButton;
	
	IBOutlet HBHomeViewController *mHomeViewController;
	
	id<HBServiceProtocol>mService;
	
	id<HBMatcherProtocol,HBServiceDelegate>mMatcher;
}

+ (HBLoginViewController *)sharedLoginController;

- (IBAction)login;
- (void)service:(id<HBServiceProtocol>)service loginDidSucceedWithUser:(HBUser *)user;


@end
