//
//  HBMatcherProtocol.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBUser;
@protocol HBMatcherDelegate;

@protocol HBMatcherProtocol <NSObject>
- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser;
@property (readwrite, assign) id<HBMatcherDelegate>delegate;
@property (nonatomic, retain) HBUser *user; //ME
@end

@protocol HBMatcherDelegate <NSObject>
- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatch:(HBUser *)user strength:(CGFloat)strength;
- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatches:(NSDictionary *)matches;  //Dict of HBUser->NSNumbers (numbers are CGFloats between 0-1)
@end

