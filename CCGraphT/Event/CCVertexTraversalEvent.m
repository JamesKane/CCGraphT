//
//  CCVertexTraversalEvent.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCVertexTraversalEvent.h"

@implementation CCVertexTraversalEvent
@synthesize source = _source;
@synthesize vertex = _vertex;

- (id)initWithSource:(id)source onVertex:(id)vertex
{
    if (self = [super init]) {
        _source = source;
        _vertex = vertex;
    }
    return self;
}
@end
