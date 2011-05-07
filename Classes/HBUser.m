//
//  HBUser.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBUser.h"


@implementation HBUser
@synthesize userName = mUserName, realName = mRealName;
@synthesize avatar, artistList = mArtistList;

- (HBUser *)initWithName:(NSString *)userName
{
	if (self = [super init])
	{
		self.userName = userName;
		mArtistList = [[NSMutableArray alloc] initWithCapacity:10];
	}
	return self;
}

- (void)dealloc
{
//	HBRelease(mUserName);
//	HBRelease(mAvatar);
//	HBRelease(mRealName);
//	HBRelease(mArtistList);
	[super dealloc];
}


- (UIImage *)getAvatar
{
	if (mAvatar)
		return mAvatar;
	
	mAvatar = [[UIImage imageNamed:@"dummyUser.jpg"] retain];
	
	return mAvatar;
}
@end
