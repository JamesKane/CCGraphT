//
//  CCOrderedSet.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCOrderedSet.h"

@interface CCOrderedSet ()
@property(strong, nonatomic) NSMutableSet *set;
@property(strong, nonatomic) NSMutableArray *stack;
@end

@implementation CCOrderedSet

- (id)init {
    self = [super init];
    if (self) {
        _set = [NSMutableSet set];
        _stack = [NSMutableArray array];
    }
    return self;
}

#pragma mark --
#pragma mark NSMutableSet override methods

- (void)addObject:(id)object {
    if (![self.set containsObject:object]) {
        [self.stack addObject:object];
        [self.set addObject:object];
    }
}

- (void)removeObject:(id)object {
    if ([self.set containsObject:object]) {
        [self.stack removeObject:object];
        [self.stack removeObject:object];
    }
}

#pragma mark --
#pragma mark NSSet override methods

- (NSUInteger)count {
    return [self.stack count];
}

- (id)member:(id)object {
    return [self.set member:object];
}

- (NSEnumerator *)objectEnumerator {
    return [self.stack objectEnumerator];
}
@end
