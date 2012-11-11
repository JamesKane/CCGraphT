//
//  CCAbstractGraphIterator.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraphIterator.h"

@implementation CCAbstractGraphIterator
@synthesize crossComponentTraversal = _crossComponentTraversal;
@synthesize reuseEvents = _reuseEvents;

- (id)init
{
    if (self = [super init]) {
        self.traversalListeners = [NSMutableArray array];
        self.crossComponentTraversal = YES;
        self.reuseEvents = NO;
        self.nListeners = 0;
    }
    
    return self;
}

- (void)setCrossComponentTraversal:(BOOL)crossComponentTraversal
{
    _crossComponentTraversal = crossComponentTraversal;
}

- (BOOL)isCrossComponentTraversal
{
    return self.crossComponentTraversal;
}

- (void)setReuseEvents:(BOOL)reuseEvents
{
    _reuseEvents = reuseEvents;
}

- (void)addTraversalListener:(id<CCTraversalListener>)l
{
    if (![self.traversalListeners containsObject:l]) {
        [self.traversalListeners addObject:l];
        self.nListeners = [self.traversalListeners count];
    }
}

- (void)remove
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:@"graph iterator does not support removal" userInfo:nil];
}

- (void)removeTraversalListener:(id<CCTraversalListener>)l
{
    [self.traversalListeners removeObject:l];
    self.nListeners = [self.traversalListeners count];
}

- (void)fireConnectedComponentFinished:(CCConnectedComponentTraversalEvent *)e
{
    for (id <CCTraversalListener> l in self.traversalListeners) {
        [l connectedComponentFinished:e];
    }
}

- (void)fireConnectedComponentStarted:(CCConnectedComponentTraversalEvent *)e
{
    for (id <CCTraversalListener> l in self.traversalListeners) {
        [l connectedComponentStarted:e];
    }
}

- (void)fireEdgeTraversed:(CCEdgeTraversalEvent *)e
{
    for (id <CCTraversalListener> l in self.traversalListeners) {
        [l edgeTraversed:e];
    }
}

- (void)fireVertexTraversed:(CCVertexTraversalEvent *)e
{
    for (id <CCTraversalListener> l in self.traversalListeners) {
        [l vertexTraversed:e];
    }
}

- (void)fireVertexFinished:(CCVertexTraversalEvent *)e
{
    for (id <CCTraversalListener> l in self.traversalListeners) {
        [l vertexFinished:e];
    }
}

- (BOOL)hasNext { return NO; };
- (id)next { return nil; };
@end
