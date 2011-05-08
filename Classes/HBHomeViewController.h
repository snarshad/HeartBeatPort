//
//  HBHomeViewController.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBServiceProtocol.h"

@class HBUser;
@interface HBHomeViewController : UIViewController {
	IBOutlet UIImageView *mUserImageView;

	IBOutlet UILabel *mUserName;	
	
	IBOutlet UIButton *mFindMatchesButton;
	IBOutlet UIButton *mMyArtistsButton;
	
	NSString *mServiceName;

	HBUser *mMe;
	
}

@property (nonatomic, retain) NSString *serviceName;
@property (nonatomic, retain) HBUser *user;

- (IBAction)findMatches:(id)sender;
- (IBAction)showMyArtists:(id)sender;

@end
