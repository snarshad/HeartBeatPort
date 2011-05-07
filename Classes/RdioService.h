//
//  RdioService.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBServiceProtocol.h"
#import <Rdio/Rdio.h>

@class Rdio, HBUser;


@interface RdioService : NSObject <HBAuthenticatedServiceProtocol, RdioDelegate>{
	Rdio *rdio;
	
	HBUser *mUser;	// the logged in user
	
	NSMutableArray *mFoundUsers;
}

#pragma mark HBServiceProtocol
- (HBUser *)user;
- (NSArray *)nearbyUsers;
- (NSArray *)artistListForUser:(HBUser *)user;
#pragma mark HBAuthenticatedServiceProtocol
- (BOOL)authenticateUser:(NSString *)username password:(NSString *)password;

#pragma mark RdioDelegate
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken;

@end
