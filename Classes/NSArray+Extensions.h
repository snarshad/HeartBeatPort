//
//  NSArray+Extensions.h
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/8/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (Extensions)
- (NSArray *)objectsCommonWithArray:(NSArray *)arr;
- (NSArray *)objectsNotCommonWithArray:(NSArray *)arr;

@end
