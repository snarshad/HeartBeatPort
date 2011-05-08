//
//  NSArray+Extensions.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/8/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "NSArray+Extensions.h"


@implementation NSArray (extensions)
- (NSArray *)objectsCommonWithArray:(NSArray *)arr
{
    NSMutableArray *result = [NSMutableArray array];
    
    for( id obj in arr )
    {
        if( [self containsObject:obj] )
            [result addObject:obj];
    }
	
    return [NSArray arrayWithArray:result];
}

- (NSArray *)objectsNotCommonWithArray:(NSArray *)arr
{
    NSMutableArray *result = [NSMutableArray array];
    
    for( id obj in self )
    {
        if( ![arr containsObject:obj] )
            [result addObject:obj];
    }
	
    return [NSArray arrayWithArray:result];
}

@end
