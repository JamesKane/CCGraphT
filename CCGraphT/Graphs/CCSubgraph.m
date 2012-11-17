//
//  CCSubgraph.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCSubgraph.h"
#import "CCAbstractBaseGraph.h"
#import "CCOrderedSet.h"
#import "CCListenableGraph.h"

static const NSString *CCSG_NO_SUCH_EDGE_IN_BASE = @"no such edge in base graph";
static const NSString *CCSG_NO_SUCH_VERTEX_IN_BASE = @"no such vertex in base graph";

@interface CCSubgraph ()
@property (strong, nonatomic) CCOrderedSet *edgeSet;
@property (strong, nonatomic) CCOrderedSet *vertexSet;
@property (strong, nonatomic) NSArray *unmodifiableEdgeArray;
@property (strong, nonatomic) NSArray *unmodifiableVertexArray;
@property (weak, nonatomic) CCAbstractBaseGraph *base;
@property (nonatomic) BOOL induced;
@end

@implementation CCSubgraph

- (id)initWithGraph:(CCAbstractBaseGraph *)base usingVertexSubset:(NSArray *)vertexSubset andEdgeSubset:(NSArray *)edgeSubset
{
    self = [super init];
    if (self) {
        self.base = base;
        
        self.edgeSet = [[CCOrderedSet alloc] init];
        self.vertexSet = [[CCOrderedSet alloc] init];
        
        if (edgeSubset == nil) {
            self.induced = true;
        }
        
//        if ([base conformsToProtocol:@protocol(CCListenableGraph)]) {
//            [((id<CCListenableGraph>)base) addGraphListener:[[CCBaseGraphListener alloc] init]];
//        }
        
        [self addVertices:[base vertexArray] usingFilter:vertexSubset];
        [self addEdges:[base edgeArray] usingFilter:edgeSubset];
    }
    
    return self;
}

- (id)initWithGraph:(CCAbstractBaseGraph *)base usingVertexSubset:(NSArray *)vertexSubset
{
    return [self initWithGraph:base usingVertexSubset:vertexSubset andEdgeSubset:nil];
}

#pragma mark --
#pragma mark Graph override methods

- (NSArray *)allEdges:(id)sourceVertex to:(id)targetVertex
{
    NSMutableSet *edges = [NSMutableSet set];
    
    if ([self containsVertex:sourceVertex] && [self containsVertex:targetVertex]) {
        NSArray *baseEdges = [self.base allEdges:sourceVertex to:targetVertex];
        for (id e in baseEdges) {
            if ([self.edgeSet containsObject:e]) {
                [edges addObject:e];
            }
        }
    }
    
    return [NSArray arrayWithArray:[edges allObjects]];
}

- (id)getEdge:(id)sourceVertex to:(id)targetVertex
{
    NSArray *edges = [self allEdges:sourceVertex to:targetVertex];
    if (!edges || [edges count] == 0) {
        return nil;
    } else {
        return [edges objectAtIndex:0];
    }
}

- (id<CCEdgeFactory>)edgeFactory
{
    return [self.base edgeFactory];
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    [self assertVertexExists:sourceVertex];
    [self assertVertexExists:targetVertex];
    
    if (![self.base containsEdge:sourceVertex to:targetVertex]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:CCSG_NO_SUCH_EDGE_IN_BASE userInfo:nil];
    }
    
    NSArray *edges = [self.base allEdges:sourceVertex to:targetVertex];
    for (id e in edges) {
        if (![self containsEdge:e]) {
            [self.edgeSet addObject:e];
            self.unmodifiableEdgeArray = nil;
            return e;
        }
    }
    
    return nil;
}

- (BOOL)addEdge:(id)sourceVertex to:(id)targetVertex with:(id)edge
{
    if (edge == nil) {
        @throw [NSException exceptionWithName:@"NilPointerException" reason:@"a nil edge is not allowed" userInfo:nil];
    }
    
    if (![self.base containsEdge:edge]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:CCSG_NO_SUCH_EDGE_IN_BASE userInfo:nil];
    }
    
    [self assertVertexExists:sourceVertex];
    [self assertVertexExists:targetVertex];
    
    if ([self containsEdge:edge]) {
        return NO;
    } else {
        [self.edgeSet addObject:edge];
        self.unmodifiableEdgeArray = nil;
        return YES;
    }
}

- (BOOL)addVertex:(id)vertex
{
    if (vertex == nil) {
        @throw [NSException exceptionWithName:@"NilPointerException" reason:@"a nil vertex is not allowed" userInfo:nil];
    }
    
    if (![self.base containsVertex:vertex]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:CCSG_NO_SUCH_VERTEX_IN_BASE userInfo:nil];
    }
    
    if ([self containsVertex:vertex]) {
        return NO;
    } else {
        [self.vertexSet addObject:vertex];
        self.unmodifiableVertexArray = nil;
        return YES;
    }
}

- (BOOL)containsEdge:(id)edge
{
    return [self.edgeSet containsObject:edge];
}

- (BOOL)containsVertex:(id)vertex
{
    return [self.vertexSet containsObject:vertex];
}

- (NSArray *)edgeArray
{
    if (!self.unmodifiableEdgeArray) {
        self.unmodifiableEdgeArray = [NSArray arrayWithArray:[self.edgeSet allObjects]];
    }
    
    return self.unmodifiableEdgeArray;
}

- (NSArray *)edgesOf:(id)vertex
{
    [self assertVertexExists:vertex];
    
    NSMutableArray *edges = [NSMutableArray array];
    NSArray *baseEdges = [self.base edgesOf:vertex];
    
    for (id e in baseEdges) {
        if ([self containsEdge:e]) {
            [edges addObject:e];
        }
    }
    
    return edges;
}

- (BOOL)removeEdge:(id)edge
{
    BOOL exists = [self.edgeSet containsObject:edge];
    if (exists) {
        [self.edgeSet removeObject:edge];
        self.unmodifiableEdgeArray = nil;
    }
    return exists;
}

- (id)removeEdge:(id)sourceVertex to:(id)targetVertex
{
    id e = [self getEdge:sourceVertex to:targetVertex];
    return [self removeEdge:e] ? e : nil;
}

- (BOOL)removeVertex:(id)vertex
{
    BOOL exists = [self containsVertex:vertex];
    if (exists) {
        if ([self.base containsVertex:vertex]) {
            [self removeAllEdges:[self edgesOf:vertex]];
        }
        [self.vertexSet removeObject:vertex];
        self.unmodifiableVertexArray = nil;
    }
    return exists;
}

- (NSArray *)vertexArray
{
    if (!self.unmodifiableVertexArray) {
        self.unmodifiableVertexArray = [NSArray arrayWithArray:[self.vertexSet allObjects]];
    }
    
    return self.unmodifiableVertexArray;
}

- (id)edgeSource:(id)edge
{
    return [self.base edgeSource:edge];
}

- (id)edgeTarget:(id)edge
{
    return [self.base edgeTarget:edge];
}

- (double)edgeWeight:(id)edge
{
    return [self.base edgeWeight:edge];
}

- (void)setEdge:(id)edge withWeight:(double)weight
{
    [self.base setEdge:edge withWeight:weight];
}

#pragma mark --
#pragma mark Private Subgraph methods

- (void)addVertices:(NSArray *)vertexArray usingFilter:(NSArray *)filter
{
    for (id v in vertexArray) {
        if (!filter || [filter containsObject:v]) {
            [self addVertex:v];
        }
    }
}

- (void)addEdges:(NSArray *)edgeArray usingFilter:(NSArray *)filter
{
    BOOL containsVertices;
    BOOL edgeIncluded;
    for (id e in edgeArray) {
        id sourceVertex = [self.graph edgeSource:e];
        id targetVertex = [self.graph edgeTarget:e];
        containsVertices = [self containsVertex:sourceVertex] && [self containsVertex:targetVertex];
        edgeIncluded = (filter == nil) || [filter containsObject:e];
        
        if (containsVertices && edgeIncluded) {
            [self addEdge:sourceVertex to:targetVertex with:e];
        }
    }
}
@end
