//
//  HBUser.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HBUser : NSObject {
	NSString *mUserName;
	NSString *mRealName;

	UIImage *mAvatar;
	
	NSMutableArray *mArtistList;
	
	NSMutableDictionary *mUserData;	//might be different service to service
}

@property (nonatomic, retain)	NSString *userName;
@property (nonatomic, retain)	NSString *realName;
@property (nonatomic, retain)	UIImage *avatar;
@property (nonatomic, readonly) NSArray *artistList;
@property (nonatomic, readonly)	NSMutableDictionary *userData;




@end
