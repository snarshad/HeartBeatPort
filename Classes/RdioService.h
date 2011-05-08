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


@interface RdioService : NSObject <HBServiceProtocol>{
	Rdio *rdio;
	
	HBUser *mUser;	// the logged in user
	
	NSMutableArray *mFoundUsers;
}

+ (Rdio *)rdioInstance;

#pragma mark HBServiceProtocol
- (HBUser *)user;
- (NSArray *)nearbyUsers;
- (NSArray *)artistListForUser:(HBUser *)user;
#pragma mark HBAuthenticatedServiceProtocol

@end
