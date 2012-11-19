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
//    
//    if ([self hash] != [object hash])
//        return NO;
    
    if ([object isKindOfClass:[self class]]) {       
        return ((_source == ((CCIntrusiveEdge *)object)->_source) || [_source isEqual:((CCIntrusiveEdge *)object)->_source]) &&
               ((_target == ((CCIntrusiveEdge *)object)->_target) || [_target isEqual:((CCIntrusiveEdge *)object)->_target]);

    }
    
    return NO;
}

#define NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (NSUINT_BIT - howmuch)))
- (NSUInteger)hash
{
    return NSUINTROTATE([_source hash], NSUINT_BIT / 2) ^ [_target hash];
}
@end
