//
//  HBMatcherProtocol.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBUser;

@protocol HBMatcherProtocol
- (CGFloat)matchUser:(HBUser *)sourceUser withUser:(HBUser *)targetUser;
@end
