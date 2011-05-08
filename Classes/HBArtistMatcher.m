//
//  HBArtistMatcher.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBArtistMatcher.h"
#import "HBUser.h"

@interface HBArtistMatcher (private)
- (void)matchAllUsers;
@end

@implementation HBArtistMatcher
@synthesize delegate;

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
	HBRelease(mMatchedUsersByKey);
	HBRelease(mUser);
	HBRelease(mUsersToMatch);
	[super dealloc];
}

- (void)service:(id<HBServiceProtocol>)service nearbyUserFound:(HBUser *)user
{
	if (!mUsersToMatch)
	{
		mUsersToMatch = [[NSMutableArray alloc] initWithCapacity:10];
	}
	if (!mMatchedUsersByKey)
	{
		mMatchedUsersByKey = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	[mUsersToMatch addObject:user];
	[mMatchedUsersByKey setObject:user forKey:[user.userData objectForKey:@"key"]];
	[self matchAllUsers];
}



- (void)service:(id<HBServiceProtocol>)service nearbyUsersFound:(NSArray *)users
{
	[mUsersToMatch addObjectsFromArray:users];
	
	[self matchAllUsers];
	
	//TODO: do something with the matches!
}


#pragma mark matching
- (void)matchAllUsers
{
	NSMutableDictionary *allMatches = [NSMutableDictionary dictionaryWithCapacity:10];
	for (HBUser *targetUser in mUsersToMatch)
	{
		CGFloat matchStrength = [self matchUser:mUser withUser:targetUser];
		if (matchStrength > 0.0)
		{
			[allMatches setObject:[NSNumber numberWithFloat:matchStrength] forKey:[targetUser.userData valueForKey:@"key"]];
		}
	}

	NSString *bestMatch = nil;
	CGFloat bestStrength = 0.0f;
	
	for (NSString *matchKey in [allMatches allKeys])
	{
		NSNumber *strength = [allMatches objectForKey:matchKey];
		
		if ([strength floatValue] > bestStrength)
		{
			bestStrength = [strength floatValue];
			bestMatch = matchKey;
		}
		
	}
	NSLog(@"Matches: %@", allMatches);
	
	[delegate matcher:self foundMatch:[mMatchedUsersByKey objectForKey:bestMatch] strength:bestStrength];

}


- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser
{
	NSArray *sourceArtists = [sourceUser artistList];
	NSArray *targetArtists = [targetUser artistList];
	
	//TODO: Do some magic
	
	return (random() % 100) / 100.0;
}

@end
