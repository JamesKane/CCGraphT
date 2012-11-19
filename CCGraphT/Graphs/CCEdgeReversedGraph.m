//
//  CCEdgeReversedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCEdgeReversedGraph.h"

@implementation CCEdgeReversedGraph

- (id)edgeConnecting:(id)sourceVertex to:(id)targetVertex
{
    return [super edgeConnecting:targetVertex to:sourceVertex];
}

- (NSArray *)allEdgesConnecting:(id)sourceVertex to:(id)targetVertex
{
    return [super allEdgesConnecting:targetVertex to:sourceVertex];
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    return [super createEdgeFromVertex:targetVertex toVertex:sourceVertex];
}

- (BOOL)addEdge:(id)edge from:(id)sourceVertex to:(id)targetVertex
{
    return [super addEdge:sourceVertex from:edge to:targetVertex];
}

- (NSInteger)inDegreeOf:(id)vertex
{
    return [super outgoingDegreeOf:vertex];
}

- (NSInteger)outgoingDegreeOf:(id)vertex
{
    return [super inDegreeOf:vertex];
}

- (NSArray *)incomingEdgesOf:(id)vertex
{
    return [super outgoingEdgesOf:vertex];
}

- (NSArray *)outgoingEdgesOf:(id)vertex
{
    return [super incomingEdgesOf:vertex];
}

- (id)removeEdgeConnecting:(id)sourceVertex to:(id)targetVertex
{
    return [super removeEdgeConnecting:targetVertex to:sourceVertex];
}

- (id)edgeSource:(id)edge
{
    return [super edgeTarget:edge];
}

- (id)edgeTarget:(id)edge
{
    return [super edgeSource:edge];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Graph = [%@, %@]", [self vertexSet], [self edgeSet]];
}

@end
