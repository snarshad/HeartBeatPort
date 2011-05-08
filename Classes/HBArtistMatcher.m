//
//  HBArtistMatcher.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBArtistMatcher.h"
#import "HBUser.h"

@implementation HBArtistMatcher


- (HBArtistMatcher *)initWithUser:(HBUser *)user
{
	if (!user)
		return nil;
	
	if (self = [super init])
	{
		mUser = [user retain];
	}
	return self;
}

- (void)dealloc
{
	HBRelease(mUser);
	HBRelease(mUsersToMatch);
	[super dealloc];
}

- (void)service:(id<HBServiceProtocol>)service nearbyUsersFound:(NSArray *)users
{
	[users retain];
	HBRelease(mUsersToMatch);
	mUsersToMatch = users;
	
	NSMutableDictionary *allMatches = [NSMutableDictionary dictionaryWithCapacity:10];
	
	for (HBUser *targetUser in users)
	{
		CGFloat matchStrength = [self matchUser:mUser withUser:targetUser];
		if (matchStrength > 0.0)
		{
			[allMatches setObject:[NSNumber numberWithFloat:matchStrength] forKey:targetUser];
		}
	}
	
	//TODO: do something with the matches!
	NSLog(@"Matches: %@", allMatches);
	
}



- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser
{
	NSArray *sourceArtists = [sourceUser artistList];
	NSArray *targetArtists = [targetUser artistList];
	
	//TODO: Do some magic
	
	return (random() % 100) / 100.0;
}

@end
