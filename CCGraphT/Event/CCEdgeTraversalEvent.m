//
//  CCEdgeTraversalEvent.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCEdgeTraversalEvent.h"

@implementation CCEdgeTraversalEvent
@synthesize source = _source;
@synthesize edge = _edge;

- (id)initWithSource:(id)eventSource onEdge:(id)edge {
    if (self = [super init]) {
        _source = eventSource;
        _edge = edge;
    }
    return self;
}

@end
