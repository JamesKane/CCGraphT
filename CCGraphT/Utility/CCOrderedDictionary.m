//
//  CCOrderedDictionary.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCOrderedDictionary.h"

@interface CCOrderedDictionary () {
    NSMutableDictionary *_dictionary;
    NSMutableArray *_orderStack;
}
@end

@implementation CCOrderedDictionary

#pragma mark --
#pragma NSDictionary overrides

- (id)init {
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionary];
        _orderStack = [NSMutableArray array];
    }

    return self;
}

- (id)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] initWithCapacity:numItems];
        _orderStack = [[NSMutableArray alloc] initWithCapacity:numItems];
    }

    return self;
}

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {

    self = [super init];

    if (self) {
        _dictionary = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
        _orderStack = [NSMutableArray arrayWithArray:keys];
    }

    return self;
}

- (NSUInteger)count {
    return [_dictionary count];
}

- (id)objectForKey:(id)aKey {
    return _dictionary[aKey];
}

- (NSEnumerator *)keyEnumerator {
    return [_orderStack objectEnumerator];
}

- (NSArray *)allKeys {
    return _orderStack;
}

#pragma mark --
#pragma NSMutableDictionary overrides

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!_dictionary[aKey])
        [_orderStack addObject:aKey];
    _dictionary[aKey] = anObject;
}

- (void)removeObjectForKey:(id)aKey {
    [_dictionary removeObjectForKey:aKey];
    [_orderStack removeObject:aKey];
}

+ (id)dictionary {
    CCOrderedDictionary *result = [[CCOrderedDictionary alloc] init];
    return result;
}
@end
