//
//  HBArtistMatcher.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBMatcherProtocol.h"
#import "HBServiceProtocol.h"

@interface HBArtistMatcher : NSObject <HBMatcherProtocol, HBServiceDelegate> {

	HBUser *mUser;
	NSMutableArray *mUsersToMatch;
	id <HBMatcherDelegate>delegate;
	NSMutableDictionary *mMatchedUsersByKey;	
	
	BOOL alreadyMatching;
}

@property (nonatomic, retain) HBUser *user; //ME

- (void)service:(id<HBServiceProtocol>)service nearbyUsersFound:(NSArray *)users;
- (void)service:(id<HBServiceProtocol>)service nearbyUserFound:(HBUser *)user;
- (void)service:(id<HBServiceProtocol>)service nearbyMatchDataAcquired:(HBUser *)user;

- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser;
@end

