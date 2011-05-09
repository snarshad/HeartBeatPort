//
//  RdioService.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "RdioService.h"
#import "HBUser.h"
#import <Rdio/Rdio.h>
#import "HBLoginViewController.h"


@interface HBUser (RdioService)
+ (HBUser *)HBUserFromRdioResult:(NSDictionary *)rdioUserDict;
@end

@interface RdioService (Private)
- (NSArray *)followedPeople;
- (void)getHeavyRotationForUser:(HBUser *)user;
- (void)getArtistsForUser:(HBUser *)user;
@end

@implementation RdioService
@synthesize loginDelegate, delegate;

static Rdio *s_rdio=nil;

- (RdioService *)init
{
	if (self = [super init])
	{
		rdio = [[Rdio alloc] initWithConsumerKey:@"8qqfmsqn4dqkqnpc6jcfcmej" andSecret:@"sDyHtdCu8C" delegate:nil];		
		s_rdio = rdio;
		s_rdio.delegate = [HBLoginViewController sharedLoginController];
		mHBUsersByUserKey = [[NSMutableDictionary alloc] init];
		mArtistsByKey =  [[NSMutableDictionary alloc] init];
		
	}
	return self;
}

+ (Rdio *)rdioInstance
{
	if (s_rdio == nil)
	{
		s_rdio = [[RdioService alloc] init];
		s_rdio.delegate = self;
	}
	return s_rdio;
}

- (void)dealloc
{
	HBRelease(mHBUsersByUserKey);
	HBRelease(mUser);
	HBRelease(rdio);
	HBRelease(mFoundUsers);
	
	[super dealloc];
}

#pragma mark HBServiceProtocol
- (void)setUser:(HBUser *)user
{
	[user retain];
	HBRelease(mUser);
	mUser = user;
	if (user)
	{
		[[NSUserDefaults standardUserDefaults] setObject:[mUser.userData valueForKey:@"accessToken"] forKey:@"rdioSavedUserToken"];
		[self getArtistsForUser:user];
	}
}

- (HBUser *)user
{
	if (mUser)
		return mUser;
	//If there was a saved user, reload
	NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"rdioSavedUserToken"];
	
	if (token)
	{
		[s_rdio authorizeUsingAccessToken:token fromController:[HBLoginViewController sharedLoginController]];
	} else {
		[rdio authorizeFromController:[HBLoginViewController sharedLoginController]];
	}
	return nil;

}

- (NSArray *)nearbyUsers
{
	//TODO: Implement!
	return nil;
}


static NSDate *lastRequest = nil;
- (void)getArtistsForUser:(HBUser *)user
{
	NSLog(@"Get Artists: %@", user);
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSDate *lastDate = nil;
	@synchronized(self)
	{
		lastDate = [lastRequest retain];

		while (lastRequest && [[NSDate date] timeIntervalSinceDate:lastRequest] < .11)
		{
			//NSLog(@"sleeping");
			usleep(11000);
			//NSLog(@"awake");
		}
		
		HBRelease(lastDate);	
		HBRelease(lastRequest);
		lastRequest = [[NSDate date] retain];
	}
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[user.userData objectForKey:@"key"], @"user",
							@"artists", @"type",
							@"30", @"limit",
							//							@"false", @"friends",
							nil];
	
	[s_rdio callAPIMethod:@"getArtistsInCollection"
		   withParameters:params
				 delegate:self];
	
	//Give the run loop time to come back
	if (![NSThread isMainThread])
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];
	[pool drain];
	
}

- (void)getHeavyRotationForUser:(HBUser *)user
{
	NSLog(@"Get Heavy: %@", user);
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSDate *lastDate = nil;
	@synchronized(self)
	{
		lastDate = [lastRequest retain];
	
		while (lastRequest && [[NSDate date] timeIntervalSinceDate:lastRequest] < .11)
		{
			//NSLog(@"sleeping");
			usleep(11000);
			//NSLog(@"awake");
		}
		
		HBRelease(lastDate);	
		HBRelease(lastRequest);
		lastRequest = [[NSDate date] retain];
	}
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[user.userData objectForKey:@"key"], @"user",
							@"artists", @"type",
							@"300", @"limit",
//							@"false", @"friends",
								nil];
	
	[s_rdio callAPIMethod:@"getHeavyRotation"
										 withParameters:params
											   delegate:self];
	
	//Give the run loop time to come back
	if (![NSThread isMainThread])		
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10.0]];

	[pool drain];
}	


- (void)searchForNearbyUsers
{
//	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//							[mUser.userData objectForKey:@"key"], @"user",
//							@"true", @"friends",
//							@"artists", @"type",
//							@"items", @"30",
//								nil];
//	
//	[s_rdio callAPIMethod:@"getHeavyRotation"
//										 withParameters:params
//											   delegate:self];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							[mUser.userData objectForKey:@"key"], @"user",
							@"30", @"count",
							nil];
	
	[s_rdio callAPIMethod:@"userFollowing"
		   withParameters:params
				 delegate:self];
}

- (NSArray *)followedPeople
{
	return nil;
}

- (NSArray *)artistListForUser:(HBUser *)user
{
	//TODO: Implement!
	return nil;	
}

#pragma mark -
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken {	
	NSString *userName = [NSString stringWithFormat:@"%@ %@", [user valueForKey:@"firstName"], [user valueForKey:@"lastName"]];
	
	HBUser *rdioUser = [[HBUser alloc] initWithName:userName];
	[rdioUser.userData setObject:accessToken forKey:@"accessToken"];
	[rdioUser.userData addEntriesFromDictionary:user];
	
	if ([user valueForKey:@"icon"])
	{
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[user valueForKey:@"icon"]]];
		if (imageData)
		{
			UIImage *image = [UIImage imageWithData:imageData];
			if (image)
				rdioUser.avatar = image;
		}
		
	}
	
	[rdioUser.userData setObject:accessToken forKey:@"accessToken"];
	[rdioUser.userData addEntriesFromDictionary:user];

	[self setUser:rdioUser];

	[loginDelegate service:self loginDidSucceedWithUser:rdioUser];
}

/**
 * Authentication failed so we should alert the user.
 */
- (void)rdioAuthorizationFailed:(NSString *)message {
	NSLog(@"Rdio authorization failed: %@", message);
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rdioSavedUserToken"];
}

#pragma mark -
- (void)rdioRequest:(RDAPIRequest *)request didLoadData:(id)data
{
	//NSLog(@"Rdio answered %@", data);
	if ([[[request parameters] objectForKey:@"method"] isEqualToString:@"userFollowing"])
	{
		for (NSDictionary *userDict in data)
		{
			HBUser *user = [HBUser HBUserFromRdioResult:userDict];
			NSString *key = [user.userData valueForKey:@"key"];
			[mHBUsersByUserKey setObject:user forKey:key];
			[user getAvatar];
			NSLog(@"About to get artists: %@", user);

			[NSThread detachNewThreadSelector:@selector(getArtistsForUser:) toTarget:self withObject:user];			
		}
	} else if ([[[request parameters] objectForKey:@"method"] isEqualToString:@"getArtistsInCollection"]) {
		HBUser *user = [mHBUsersByUserKey objectForKey:[[request parameters] objectForKey:@"user"]];
		
		if (!user)
		{
			if ([[[request parameters] objectForKey:@"user"] isEqualToString:[mUser.userData objectForKey:@"key"]])
			{
				user = mUser;
			}
		}
		NSLog(@"Adding %d artists for user %@", [data count], [user userName]);
		for (NSDictionary *artistsDict in data) {
			NSString *artist = [artistsDict objectForKey:@"name"];
			
			[user addArtist:artist weight:[NSNumber numberWithInt:1]];
			
			@synchronized(mArtistsByKey)
			{
				if (![[mArtistsByKey allKeys] containsObject:[artistsDict valueForKey:@"key"]])
				{
					[mArtistsByKey setObject:artistsDict forKey:[artistsDict valueForKey:@"key"]];
				}
			}
		}
		if (user != mUser)
		{
			[delegate service:self nearbyUserFound:user];
		}
		[self getHeavyRotationForUser:user];
	} else if ([[[request parameters] objectForKey:@"method"] isEqualToString:@"getHeavyRotation"]) {
		HBUser *user = [mHBUsersByUserKey objectForKey:[[request parameters] objectForKey:@"user"]];
		
		if (!user)
		{
			if ([[[request parameters] objectForKey:@"user"] isEqualToString:[mUser.userData objectForKey:@"key"]])
			{
				user = mUser;
			}
		}
		NSLog(@"Adding %d heavy rotation artists for user %@", [data count], [user userName]);
		for (NSDictionary *rotationDict in data) {
			NSString *artist = [rotationDict objectForKey:@"name"];
			
			[user addArtist:artist weight:[rotationDict valueForKey:@"hits"]];
			
			@synchronized(mArtistsByKey)
			{
				if (![[mArtistsByKey allKeys] containsObject:[rotationDict valueForKey:@"key"]])
				{
					[mArtistsByKey setObject:rotationDict forKey:[rotationDict valueForKey:@"key"]];
				}
			}
		}
		if (user && user != mUser)
		{
			[delegate service:self nearbyMatchDataAcquired:user];
		}
	}

	
	
	
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
	NSLog(@"Rdio request failed: %@", error);	
}


@end

@implementation HBUser (RdioService)

//userFollowers
//userFollowing  params: user => @"key", @"start" (def 0), @"count" (def 10), @"extras"=>?

+ (HBUser *)HBUserFromRdioResult:(NSDictionary *)rdioUserDict
{
	//NSString *key = [rdioUserDict objectForKey:@"key"];
	
	NSString *name = [rdioUserDict objectForKey:@"firstName"];
	if ([[rdioUserDict objectForKey:@"lastName"] length] > 0)
	{
		name = [name stringByAppendingFormat:@" %@", [rdioUserDict objectForKey:@"lastName"]]; 
	}
	
	HBUser *user = [[HBUser alloc] initWithName:name];
	
	if ([[rdioUserDict objectForKey:@"gender"] isEqualToString:@"f"])
		user.gender = @"Female";
	else {
		user.gender = @"Male";
	}
	
	[user.userData addEntriesFromDictionary:rdioUserDict];
	return user;	
}

@end

