//
//  CCConnectedComponentTraversalEvent.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCConnectedComponentTraversalEvent.h"

@implementation CCConnectedComponentTraversalEvent
@synthesize source = _source;
@synthesize type = _type;

- (id)initWith:(id)source forEvent:(ConnectedComponentEventType)type {
    if (self = [super init]) {
        _source = source;
        _type = type;
    }
    return self;
}

@end
