//
//  CCIntrusiveEdge.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCIntrusiveEdge.h"

@implementation CCIntrusiveEdge
@synthesize source = _source;
@synthesize target = _target;

- (id)copyWithZone:(NSZone *)zone
{
    CCIntrusiveEdge *newEdge = [[[self class] allocWithZone:zone] init];
    
    if (newEdge) {
        newEdge.source = self.source;
        newEdge.target = self.target;
    }
    
    return newEdge;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
        return YES;
    
    if ([object isKindOfClass:[self class]]) {
        return [self.source isEqual:((CCIntrusiveEdge *)object).source] && [self.target isEqual:((CCIntrusiveEdge *)object).target];
    }
    
    return NO;
}
@end
