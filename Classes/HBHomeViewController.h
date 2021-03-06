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
#import "HBUser.h"

@class HBUser, HBUserViewController;
@interface HBHomeViewController : UIViewController <HBMatcherDelegate, HBUserDelegate> {
	IBOutlet UIImageView *mUserImageView;
	IBOutlet UIImageView *mMatchImageView;
	IBOutlet UILabel *mMatchname;	

	IBOutlet UILabel *mUserName;	
	
	IBOutlet UIButton *mFindMatchesButton;
	IBOutlet UIButton *mMyArtistsButton;
	
	HBUser *mMe;
	
	NSMutableDictionary *mMatchedUsers; //Dictionary of @"user"->HBUser, @"strength" => NSNumber (CGFloat)

	id<HBServiceProtocol>mService;
	id<HBMatcherProtocol,HBServiceDelegate>mMatcher;
	HBUserViewController *mResultController;
	
	CGFloat bestStrength;
	HBUser *bestMatch;
	
}

@property (nonatomic, retain) id<HBMatcherProtocol,HBServiceDelegate>matcher;
@property (nonatomic, retain) id<HBServiceProtocol>service;
@property (nonatomic, retain) HBUser *user;



- (IBAction)findMatches:(id)sender;
- (IBAction)showMyArtists:(id)sender;

#pragma mark HBMatcherDelegate
- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatch:(HBUser *)user strength:(CGFloat)strength;
- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatches:(NSDictionary *)matches;  //dict of @"user"->HBUser, @"strength" => NSNumber (CGFloat)

- (void)avatarRetrieved:(HBUser *)user;

@end
