//
//  CCGraphs.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphs.h"

@implementation CCGraphs

+ (id)createEdgeInGraph:(id<CCGraph>)g from:(id)sourceVertex to:(id)targetVertex withWeight:(double)weight
{
    id<CCEdgeFactory> ef = [g edgeFactory];
    id e = [ef createEdge:sourceVertex to:targetVertex];
    
    if ([g conformsToProtocol:@protocol(CCWeightedGraph)]) {
        [(id <CCWeightedGraph>)g setEdge:e withWeight:weight];
    }
    
    return [g addEdge:sourceVertex to:targetVertex with:e] ? e : nil;
}

+ (id)addEdge:(id)e toGraph:(id<CCGraph>)g from:(id)sourceVertex to:(id)targetVertex
{
    [g addVertex:sourceVertex];
    [g addVertex:targetVertex];
    
    return [g createEdgeFromVertex:sourceVertex toVertex:targetVertex];
}

+ (BOOL)addEdge:(id)edge fromGraph:(id<CCGraph>)sourceGraph toGraph:(id<CCGraph>)targetGraph
{
    id sourceVertex = [sourceGraph edgeSource:edge];
    id targetVertex = [sourceGraph edgeTarget:edge];
    
    [targetGraph addVertex:sourceVertex];
    [targetGraph addVertex:targetVertex];
    
    return [targetGraph addEdge:sourceVertex to:targetVertex with:edge];
}

+ (id)createEdgeInGraph:(id<CCGraph>)g adding:(id)sourceVertex to:(id)targetVertex withWeight:(double)weight
{
    [g addVertex:sourceVertex];
    [g addVertex:targetVertex];
    
    return [self createEdgeInGraph:g from:sourceVertex to:targetVertex withWeight:weight];
}

+ (BOOL)addToGraph:(id<CCGraph>)destination fromGraph:(id<CCGraph>)source
{
    BOOL modified = [self addAllVerticesToGraph:destination fromArray:[source vertexArray]];
    modified |= [self addAllEdgesToGraph:destination fromGraph:source fromArray:[source edgeArray]];
    return modified;
}

+ (void)addReversedToGraph:(id<CCGraph>)destination fromGraph:(id<CCGraph>)source
{
    [self addAllVerticesToGraph:destination fromArray:[source vertexArray]];
    for (id edge in [source edgeArray]) {
        [destination createEdgeFromVertex:[source edgeTarget:edge] toVertex:[source edgeSource:edge]];
    }
}

+ (BOOL)addAllEdgesToGraph:(id<CCGraph>)destination fromGraph:(id<CCGraph>)source fromArray:(NSArray *)edges
{
    BOOL modified = NO;
    
    for (id e in edges) {
        id s = [source edgeSource:e];
        id t = [source edgeTarget:e];
        [destination addVertex:s];
        [destination addVertex:t];
        modified |= [destination addEdge:s to:t with:e];
    }
    
    return modified;
}

+ (BOOL)addAllVerticesToGraph:(id<CCGraph>)destination fromArray:(NSArray *)vertices
{
    BOOL modified = NO;
    
    for (id v in vertices) {
        modified |= [destination addVertex:v];
    }
    
    return modified;
}

+ (NSArray *)predecessorsListOf:(id)vertex inGraph:(id<CCDirectedGraph>)g
{
    NSMutableArray *predecessors = [NSMutableArray array];
    NSArray *edges = [g incomingEdgesOf:vertex];
    
    for (id e in edges) {
        [predecessors addObject:[self oppositeVertexInEdge:e fromVertex:vertex inGraph:g]];
    }
    
    return predecessors;
}

+ (NSArray *)successorListOf:(id)vertex inGraph:(id<CCDirectedGraph>)g
{
    NSMutableArray *successors = [NSMutableArray array];
    NSArray *edges = [g outgoingEdgesOf:vertex];
    
    for (id e in edges) {
        [successors addObject:[self oppositeVertexInEdge:e fromVertex:vertex inGraph:g]];
    }
    
    return successors;
}

+ (BOOL)testEdge:(id)e isIncident:(id)v inGraph:(id<CCGraph>)g
{
    return [[g edgeSource:e] isEqual:v] || [[g edgeTarget:e] isEqual:v];
}

+ (id)oppositeVertex:(id<CCGraph>)graph for:(id)edge from:(id)vertex
{
    id source = [graph edgeSource:edge];
    id target = [graph edgeTarget:edge];
    if ([vertex isEqual:source]) {
        return target;
    } else if ([vertex isEqual:target]) {
        return source;
    } else {
        return nil;
    }
}

+ (id)oppositeVertexInEdge:(id)edge fromVertex:(id)vertex inGraph:(id<CCGraph>)graph
{
    id source = [graph edgeSource:edge];
    id target = [graph edgeTarget:edge];
    if ([vertex isEqual:source]) {
        return target;
    } else if ([vertex isEqual:target]) {
        return source;
    } else {
        return nil;
    }
}

+ (NSArray *)pathVertexList:(id<CCGraphPath>)path
{
    id<CCGraph> g = [path graph];
    NSMutableArray *list = [NSMutableArray array];
    id v = [path startVertex];
    [list addObject:v];
    for (id e in [path edgeList]) {
        v = [self oppositeVertex:g for:e from:v];
        [list addObject:v];
    }
    return list;
}
@end
