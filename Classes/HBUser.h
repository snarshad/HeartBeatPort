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
}

@property (nonatomic, retain)	NSString *userName;
@property (nonatomic, retain)	NSString *realName;
@property (nonatomic, readonly)	UIImage *avatar;
@property (nonatomic, readonly) NSArray *artistList;




@end
