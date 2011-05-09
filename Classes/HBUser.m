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
@synthesize userData = mUserData;
@synthesize gender = mGender;
@synthesize service = mService;
@synthesize artistToWeightsDict = mArtistToWeightsDict;
@synthesize delegate;

- (HBUser *)initWithName:(NSString *)userName
{
	if (self = [super init])
	{
		self.userName = userName;
		mArtistToWeightsDict = [[NSMutableDictionary alloc] initWithCapacity:10];
		mUserData = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ %@ (%@) (%@) %d artists", [super description],  
			mUserName, 
			mGender,
			[mUserData valueForKey:@"key"],
			mArtistToWeightsDict.count];
}

- (void)dealloc
{
	HBRelease(mService);
	HBRelease(mUserName);
	HBRelease(mAvatar);
	HBRelease(mRealName);
	HBRelease(mArtistToWeightsDict);
	HBRelease(mUserData);
	[super dealloc];
}

- (void)getAvatarOnThread:(id)sender
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if ([mUserData objectForKey:@"icon"]) //rdio specific
	{
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[mUserData objectForKey:@"icon"]]];
		if (data)
		{
			mAvatar = [[UIImage alloc] initWithData:data];
		}
	}
	if (delegate && [delegate respondsToSelector:@selector(avatarRetrieved:)])
	{
		[delegate performSelectorOnMainThread:@selector(avatarRetrieved:) withObject:self waitUntilDone:NO];
	}
	[pool drain];
}


- (UIImage *)getAvatar
{
	if (mAvatar)
		return mAvatar;

//	if (!gettingAvatar)
//		[NSThread detachNewThreadSelector:@selector(getAvatarOnThread:) toTarget:self withObject:nil];
//	gettingAvatar = YES;
	[self getAvatarOnThread:self];
	
//	if ([mUserData objectForKey:@"icon"]) //rdio specific
//	{
//		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[mUserData objectForKey:@"icon"]]];
//		if (data)
//		{
//			mAvatar = [[UIImage alloc] initWithData:data];
//		}
//	}
//	
//	
//	if (!mAvatar)
//	{
//		mAvatar = [[UIImage imageNamed:@"dummyUser.jpg"] retain];		
//	}
//	
	return mAvatar;
}

- (void)addArtist:(NSString *)artist weight:(NSNumber *)weight
{
	[self willChangeValueForKey:@"artistList"];
	[mArtistToWeightsDict setObject:weight forKey:artist];
	[self didChangeValueForKey:@"artistList"];
}

- (NSArray *)artistList
{
	return [mArtistToWeightsDict allKeys];
}

@end
