//
//  CCCrossComponentIterator.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCCrossComponentIterator.h"
#import "CCGraphs.h"

@implementation CCCrossComponentIterator

- (id)initWithGraph:(CCAbstractBaseGraph *)graph startFrom:(id)startVertex
{
    if (self = [super init]) {
        self.graph = graph;
        self.specifics = [self createGraphSpecifics:graph];
        self.vertexIterator = [[graph vertexSet] objectEnumerator];
        self.crossComponentTraversal = (startVertex == nil);
        
        self.reusableEdgeEvent = [[CCFlyweightEdgeEvent alloc] initWithSource:self onEdge:nil];
        self.reusableVertexEvent = [[CCFlyweightVertexEvent alloc] initWithSource:self onVertex:nil];
        
        self.seen = [NSMutableDictionary dictionary];
        
        if (self.startVertex == nil) {
            self.startVertex = [self.vertexIterator nextObject];
        } else if ([graph containsVertex:startVertex]) {
            self.startVertex = startVertex;
        } else {
            @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"graph must cntain the start vertex" userInfo:nil];
        }
    }
    return self;
}

// Using Java's iterator pattern here since the algorithm has some events applied where I'm not sure how to refactor as yet

- (BOOL)hasNext
{
    if (self.startVertex != nil) {
        [self encounterStartVertex];
    }
    
    if ([self isConnectedComponentExhausted]) {
        if (self.state == CCS_WITHIN_COMPONENT) {
            self.State = CCS_AFTER_COMPONENT;
            if (self.nListeners != 0) {
                [self fireConnectedComponentFinished:self.ccFinishedEvent];
            }
        }
        
        if ([self isCrossComponentTraversal]) {
            id v;
            while (v = [self.vertexIterator nextObject]) {
                if (![self isSeenVertex:v]) {
                    [self encounterVertex:v with:nil];
                    self.state = CCS_BEFORE_COMPONENT;
                    
                    return YES;
                }
            }
            return NO;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}

- (id)next
{
    if (self.startVertex != nil) {
        [self encounterStartVertex];
    }
    
    if ([self hasNext]) {
        if (self.state == CCS_BEFORE_COMPONENT) {
            self.State = CCS_WITHIN_COMPONENT;
            if (self.nListeners != 0) {
                [self fireConnectedComponentFinished:self.ccStartedEvent];
            }
        }
        
        id nextVertex = [self provideNextVertex];
        if (self.nListeners != 0) {
            [self fireVertexTraversed:[self createVertexTraversalEvent:nextVertex]];
        }
        
        [self addUnseenChildrenOf:nextVertex];
        
        return nextVertex;
    }
    
    return nil;
}

- (BOOL)isConnectedComponentExhausted { return YES; }   // STUB - Children must implement this appropriately

- (void)encounterVertex:(id)vertex with:(id)edge {}     // STUB - Children must implement this appropriately

- (void)encounterVertexAgain:(id)vertex with:(id)edge {} // STUB - Children must implement this appropriately

- (id)provideNextVertex { return nil; }                 // STUB - Children must implement this appropriately

- (id)seenData:(id)vertex
{
    return [self.seen objectForKey:vertex];
}

- (BOOL)isSeenVertex:(id)vertex
{
    return [[self.seen allKeys] containsObject:vertex];
}

- (id)putSeen:(id)vertex data:(id)data
{
    [self.seen setObject:data forKey:vertex];  // TODO: Figure out what the hell the Java version is returning
    return nil;
}

- (void)finishVertex:(id)vertex
{
    if (self.nListeners != 0) {
        [self fireVertexFinished:[self createVertexTraversalEvent:vertex]];
    }
}

- (void)addUnseenChildrenOf:(id)vertex
{
    for (id edge in [self.specifics edgesOf:vertex]) {
        if (self.nListeners) {
            [self fireEdgeTraversed:[self createEdgeTraversalEvent:edge]];
        }
        
        id oppositeV = [CCGraphs oppositeVertex:self.graph for:edge from:vertex];
        
        if ([self isSeenVertex:oppositeV]) {
            [self encounterVertexAgain:oppositeV with:edge];
        } else {
            [self encounterVertex:oppositeV with:edge];
        }
    }
}

- (CCEdgeTraversalEvent *)createEdgeTraversalEvent:(id)edge
{
    if ([self isReuseEvents]) {
        self.reusableEdgeEvent.edge = edge;
        return self.reusableEdgeEvent;
    } else {
        return [[CCEdgeTraversalEvent alloc] initWithSource:self onEdge:edge];
    }
}

- (CCVertexTraversalEvent *)createVertexTraversalEvent:(id)vertex
{
    if ([self isReuseEvents]) {
        self.reusableVertexEvent.vertex = vertex;
        return self.reusableVertexEvent;
    } else {
        return [[CCVertexTraversalEvent alloc] initWithSource:self onVertex:vertex];
    }
}
@end
