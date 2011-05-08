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


@interface RdioService : NSObject <HBServiceProtocol, RDAPIRequestDelegate, RdioDelegate>{
	Rdio *rdio;
	
	HBUser *mUser;	// the logged in user
	
	NSMutableArray *mFoundUsers;
	
	id <HBServiceLoginDelegate>loginDelegate;
	id <HBServiceDelegate>delegate;
	
}
@property (readwrite, assign)id <HBServiceLoginDelegate>loginDelegate;
@property (readwrite, assign)id <HBServiceDelegate>delegate;


+ (Rdio *)rdioInstance;

#pragma mark HBServiceProtocol
- (void)setUser:(HBUser *)user;
- (HBUser *)user;
- (NSArray *)nearbyUsers;
- (NSArray *)artistListForUser:(HBUser *)user;
#pragma mark HBAuthenticatedServiceProtocol

@end
