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

@interface HBArtistMatcher : NSObject <HBMatcherProtocol, HBServiceDelegate>{

	HBUser *mUser;
	NSArray *mUsersToMatch;
}

- (void)service:(id<HBServiceProtocol>)service nearbyUsersFound:(NSArray *)users;

- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser;
@end
