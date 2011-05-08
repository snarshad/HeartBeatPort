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

@interface RdioService (Private)

- (NSArray *)followedPeople;

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
	[[NSUserDefaults standardUserDefaults] setObject:[mUser.userData valueForKey:@"accessToken"] forKey:@"rdioSavedUserToken"];
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

- (void)searchForNearbyUsers
{
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[mUser.userData objectForKey:@"key"], @"user"
							@"true", @"friends",
							@"artists", @"type",
								nil];
	
	RDAPIRequest *currentRequest =[s_rdio callAPIMethod:@"getHeavyRotation"
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
	
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
	NSLog(@"Rdio request failed: %@", error);	
}


@end
