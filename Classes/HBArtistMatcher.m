//
//  HBArtistMatcher.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBArtistMatcher.h"
#import "HBUser.h"

@implementation HBArtistMatcher


- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser
{
	NSArray *sourceArtists = [sourceUser artistList];
	NSArray *targetArtists = [targetUser artistList];
	
	//TODO: Do some magic
	
	return (random() % 100) / 100.0;
}

@end
