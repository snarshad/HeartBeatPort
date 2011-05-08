//
//  HBUser.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBServiceProtocol.h"

@interface HBUser : NSObject {
	NSString *mUserName;
	NSString *mRealName;

	UIImage *mAvatar;
	
	NSMutableDictionary *mArtistToWeightsDict;
	
	NSMutableDictionary *mUserData;	//might be different service to service
	
	NSString *mGender;
	
	id <HBServiceProtocol>mService;
}

@property (nonatomic, retain)	id <HBServiceProtocol>service;
@property (nonatomic, retain)	NSString *userName;
@property (nonatomic, retain)	NSString *gender;
@property (nonatomic, retain)	NSString *realName;
@property (nonatomic, retain)	UIImage *avatar;
@property (nonatomic, readonly) NSArray *artistList;
@property (nonatomic, readonly)	NSMutableDictionary *userData;
@property (nonatomic, readonly)	NSMutableDictionary *artistToWeightsDict;


- (void)addArtist:(NSString *)artist weight:(NSNumber *)weight;
- (UIImage *)getAvatar;



@end
