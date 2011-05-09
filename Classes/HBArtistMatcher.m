//
//  HBArtistMatcher.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBArtistMatcher.h"
#import "HBUser.h"
#import "NSArray+Extensions.h"

@interface HBArtistMatcher (private)
- (void)matchAllUsers;
@end

@implementation HBArtistMatcher
@synthesize delegate;
@synthesize user = mUser;

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
	@synchronized (self)
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
	}
	[delegate matcher:self userAdded:user];
}


- (void)service:(id<HBServiceProtocol>)service nearbyMatchDataAcquired:(HBUser *)user
{
	[NSThread detachNewThreadSelector:@selector(matchAllUsers) toTarget:self withObject:nil];
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
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (alreadyMatching)
		return;
	
	alreadyMatching = YES;
	srandom([[NSDate date] timeIntervalSince1970]);

	NSArray *users = nil;
	@synchronized (self)
	{
		users = [mUsersToMatch copy];		
	}
	
	NSLog(@"Matching %d users", users.count);

	NSMutableDictionary *allMatches = [NSMutableDictionary dictionaryWithCapacity:10];
	for (HBUser *targetUser in users)
	{
		CGFloat matchStrength = [self matchUser:mUser withUser:targetUser];
		if (matchStrength > 0.0)
		{
			[allMatches setObject:[NSNumber numberWithFloat:matchStrength] forKey:[targetUser.userData valueForKey:@"key"]];
		}
	}
	HBRelease(users);

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
//	NSLog(@"Matches: %@", allMatches);
	if (!bestMatch)
	{
		alreadyMatching = NO;
		
		[pool release];
		return;
	}
	
	
	[delegate matcher:self foundMatch:[mMatchedUsersByKey objectForKey:bestMatch] strength:bestStrength];
	
	alreadyMatching = NO;
	
	[pool release];
}


- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser
{
	NSArray *sourceArtists = [sourceUser artistList];
	NSArray *targetArtists = [targetUser artistList];
	
	//TODO: Do more magic
	NSArray *intersectionList = [sourceArtists objectsCommonWithArray:targetArtists];
	
	if ([intersectionList count] == 0)
	{
		return 0.0;
	}
	
	
	[targetUser.userData setValue:intersectionList forKey:@"commonArtists"];
	
	CGFloat base = 30.0;
	base += (random() % 30);
	
	CGFloat adjustment = (intersectionList.count);
	if (adjustment > 28)
	{
		adjustment = 29;
	}

	NSLog(@"%d intersecting artists with user %@ (%f%%)", intersectionList.count, targetUser, (base + adjustment));

	if ([targetUser.gender isEqualToString:@"Male"])
		adjustment = 0;
	
	return (base + adjustment)/100.0;
}

@end
