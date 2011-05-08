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

@implementation RdioService
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

- (NSArray *)artistListForUser:(HBUser *)user
{
	//TODO: Implement!
	return nil;	
}




@end
