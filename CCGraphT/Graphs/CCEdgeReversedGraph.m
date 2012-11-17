//
//  CCEdgeReversedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCEdgeReversedGraph.h"

@implementation CCEdgeReversedGraph

- (id)getEdge:(id)sourceVertex to:(id)targetVertex
{
    return [super getEdge:targetVertex to:sourceVertex];
}

- (NSArray *)allEdges:(id)sourceVertex to:(id)targetVertex
{
    return [super allEdges:targetVertex to:sourceVertex];
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    return [super createEdgeFromVertex:targetVertex toVertex:sourceVertex];
}

- (BOOL)addEdge:(id)sourceVertex to:(id)targetVertex with:(id)edge
{
    return [super addEdge:targetVertex to:sourceVertex with:edge];
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

- (id)removeEdge:(id)sourceVertex to:(id)targetVertex
{
    return [super removeEdge:targetVertex to:sourceVertex];
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
    return [NSString stringWithFormat:@"Graph = [%@, %@]", [self vertexArray], [self edgeArray]];
}

@end
