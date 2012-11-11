//
//  CCClosestFirstIterator.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCClosestFirstIterator.h"
#import "CCFibonacciHeap.h"
#import "CCFibonacciHeapNode.h"
#import "CCGraphs.h"

@interface CCClosestFirstIterator ()
@property (strong, nonatomic) CCFibonacciHeap *heap;
@property (nonatomic) double radius;
@property (nonatomic) BOOL initialized;
@end

@implementation CCClosestFirstIterator

- (id)initWithGraph:(CCAbstractBaseGraph *)graph
{
    return [self initWithGraph:graph startFrom:nil];
}

- (id)initWithGraph:(CCAbstractGraph *)graph startFrom:(id)startVertex
{
    return [self initWithGraph:graph startFrom:startVertex withRadius:DBL_MAX];
}

- (id)initWithGraph:(CCAbstractGraph *)graph startFrom:(id)startVertex withRadius:(double)radius
{
    if (self = [super initWithGraph:graph startFrom:startVertex]) {
        self.radius = radius;
        [self checkRadiusTraversal:[self isCrossComponentTraversal]];
        self.initialized = YES;
    }
    return self;
}

- (void)checkRadiusTraversal:(BOOL)crossComponentTraversal
{
    if (self.initialized) {
        [self checkRadiusTraversal:crossComponentTraversal];
    }
    [super setCrossComponentTraversal:crossComponentTraversal];
}

- (double)shortestPathLength:(id)vertex
{
    CCFibonacciHeapNode *node = [self seenData:vertex];
    
    if (!node) {
        return DBL_MAX;
    }
    
    return node.key;
}

- (id)spanningTreeEdge:(id)vertex
{
    CCFibonacciHeapNode *node = [self seenData:vertex];
    if (!node) {
        return nil;
    }
    
    return nil;//[node.data spanningTreeEdge];
}

- (BOOL)isConnectedComponentExhausted
{
    if (![self.heap size]) {
        return YES;
    } else {
        if ([self.heap min].key > self.radius) {
            [self.heap clear];
            return YES;
        } else {
            return NO;
        }
    }
}

- (void)encounterVertex:(id)vertex with:(id)edge
{
    double shortestPathLength;
    if (!edge) {
        shortestPathLength = 0;
    } else {
        shortestPathLength = [self calculatePathLength:vertex on:edge];
    }
    CCFibonacciHeapNode *node = [self createSeenData:vertex on:edge];
    [self putSeenData:node withKey:vertex];
    [self.heap insert:node withKey:shortestPathLength];
}

- (void)encounterVertexAgain:(id)vertex with:(id)edge
{
    CCFibonacciHeapNode *node = [self seenData:vertex];
    
    if (((CCQueueEntry *)(node.data)).frozen) {
        return;
    }
    
    double candidatePathLength = [self calculatePathLength:vertex on:edge];
    
    if (candidatePathLength < node.key) {
        ((CCQueueEntry *)(node.data)).spanningTreeEdge = edge;
        [self.heap decreaseNode:node keyTo:candidatePathLength];
    }
}

- (id)provideNextVertex
{
    CCFibonacciHeapNode *node = [self.heap removeMin];
    ((CCQueueEntry *)(node.data)).frozen = YES;
    
    return ((CCQueueEntry *)(node.data)).vertex;
}

- (void)assertNonNegativeEdge:(id)edge
{
    if ([self.graph edgeWeight:edge] < 0) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"negative edge weights no allowed" userInfo:nil];
    }
}

- (double)calculatePathLength:(id)vertex on:(id)edge
{
    [self assertNonNegativeEdge:edge];
    
    id otherVertex = [CCGraphs oppositeVertex:self.graph for:edge from:vertex];
    CCFibonacciHeapNode *otherEntry = [self seenData:otherVertex];
    
    return otherEntry.key + [self.graph edgeWeight:edge];
}

//- (void)checkRadiusTraversal:(BOOL)crossComponentTraversal
//{
//    
//}

- (CCFibonacciHeapNode *)createSeenData:(id)vertex on:(id)edge
{
    CCQueueEntry *entry = [[CCQueueEntry alloc] init];
    entry.vertex = vertex;
    entry.spanningTreeEdge = edge;
    
    return [[CCFibonacciHeapNode alloc] initWithData:entry];
}

@end

@implementation CCQueueEntry
@end
