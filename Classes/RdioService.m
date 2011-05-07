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

@implementation RdioService

- (RdioService *)init
{
	if (self = [super init])
	{
		rdio = [[Rdio alloc] initWithConsumerKey:@"8qqfmsqn4dqkqnpc6jcfcmej" andSecret:@"sDyHtdCu8C" delegate:nil];		
	}
	return self;
}

- (void)dealloc
{
	HBRelease(mUser);
	HBRelease(rdio);
	HBRelease(mFoundUsers);
	
	[super dealloc];
}

#pragma mark HBServiceProtocol
- (HBUser *)user
{
	return mUser;
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

#pragma mark HBAuthenticatedServiceProtocol
- (BOOL)authenticateUser:(NSString *)username password:(NSString *)password
{
	//TODO: implement
	return NO;
}

#pragma mark -

@end
