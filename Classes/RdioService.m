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
	[rdio authorizeFromController:self];
}

#pragma mark RdioDelegate
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken {
	HBRelease(mUser);
	
	NSString *userName = [NSString stringWithFormat:@"%@ %@", [user valueForKey:@"firstName"], [user valueForKey:@"lastName"]];
	
	mUser = [[HBUser alloc] initWithName:userName];
	
	if ([user valueForKey:@"icon"])
	{
		NSData *imageData = [NSData dataWithContentsOfURL:[user valueForKey:@"icon"]];
		if (imageData)
		{
			UIImage *image = [UIImage imageWithData:imageData];
			if (image)
				mUser.avatar = image;
		}
		
	}
	
	[mUser.userData setObject:accessToken forKey:@"accessToken"];
	[mUser.userData addEntriesFromDictionary:user];
}

/**
 * Authentication failed so we should alert the user.
 */
- (void)rdioAuthorizationFailed:(NSString *)message {
	NSLog(@"Rdio authorization failed: %@", message);
}



@end
