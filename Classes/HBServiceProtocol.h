//
//  HBServiceProtocol.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBUser;
@protocol HBServiceLoginDelegate, HBServiceDelegate;


//Some services require no login (e.g. local user library)
@protocol HBServiceProtocol <NSObject>
@property (readwrite, assign)id <HBServiceLoginDelegate>loginDelegate;
@property (readwrite, assign)id <HBServiceDelegate>delegate;


- (void)setUser:(HBUser *)user;	//I didn't want this
- (HBUser *)user;		// "me", or the logged in user

- (void)searchForNearbyUsers;

- (NSArray *)nearbyUsers;
- (NSArray *)artistListForUser:(HBUser *)user;	// gets artist lists for other users
@end

//many services requre a login
@protocol HBAuthenticatedServiceProtocol <HBServiceProtocol>
- (BOOL)authenticateUser:(NSString *)username password:(NSString *)password;
@end


//The delegate will be a class that listens for service events (like login success, nerbyUsersFound, etc)
@protocol HBServiceLoginDelegate <NSObject>
- (void)service:(id<HBServiceProtocol>)service loginDidSucceedWithUser:(HBUser *)user;
@end

@protocol HBServiceDelegate <NSObject>
- (void)service:(id<HBServiceProtocol>)service nearbyUsersFound:(NSArray *)users;
- (void)service:(id<HBServiceProtocol>)service nearbyUserFound:(HBUser *)user;
- (void)service:(id<HBServiceProtocol>)service nearbyMatchDataAcquired:(HBUser *)user;
@end