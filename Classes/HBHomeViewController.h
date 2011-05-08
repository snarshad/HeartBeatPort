//
//  HBHomeViewController.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Rdio/Rdio.h>
#import "HBServiceProtocol.h"
#import "HBMatcherProtocol.h"

@class HBUser;
@interface HBHomeViewController : UIViewController <HBMatcherDelegate> {
	IBOutlet UIImageView *mUserImageView;

	IBOutlet UILabel *mUserName;	
	
	IBOutlet UIButton *mFindMatchesButton;
	IBOutlet UIButton *mMyArtistsButton;
	
	HBUser *mMe;

	id<HBServiceProtocol>mService;
	id<HBMatcherProtocol,HBServiceDelegate>mMatcher;

}

@property (nonatomic, retain) id<HBMatcherProtocol,HBServiceDelegate>matcher;
@property (nonatomic, retain) id<HBServiceProtocol>service;
@property (nonatomic, retain) HBUser *user;



- (IBAction)findMatches:(id)sender;
- (IBAction)showMyArtists:(id)sender;

#pragma mark HBMatcherDelegate
- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatches:(NSDictionary *)matches;  //Dict of HBUser->NSNumbers (numbers are CGFloats between 0-1)
@end
