//
//  HBServiceProtocol.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBUser;

//Some services require no login (e.g. local user library)
@protocol HBServiceProtocol <NSObject>
- (void)setUser:(HBUser *)user;	//I didn't want this
- (HBUser *)user;		// "me", or the logged in user

- (NSArray *)nearbyUsers;
- (NSArray *)artistListForUser:(HBUser *)user;	// gets artist lists for other users
@end

//many services requre a login
@protocol HBAuthenticatedServiceProtocol <HBServiceProtocol>
- (BOOL)authenticateUser:(NSString *)username password:(NSString *)password;
@end
