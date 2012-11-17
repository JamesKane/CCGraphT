//
//  CCGraphDelegator.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphDelegator.h"
#import "CCAbstractBaseGraph.h"

@interface CCGraphDelegator ()
@property (strong, nonatomic) CCAbstractBaseGraph *delegate;
@end

@implementation CCGraphDelegator

- (id)initWithGraph:(CCAbstractBaseGraph *)g
{
    self = [super init];
    if (self) {
        _delegate = g;
    }
    
    return self;
}

- (NSArray *)allEdges:(id)sourceVertex to:(id)targetVertex
{
    return [self.delegate allEdges:sourceVertex to:targetVertex];
}

- (id)getEdge:(id)sourceVertex to:(id)targetVertex
{
    return [self.delegate getEdge:sourceVertex to:targetVertex];
}

- (id<CCEdgeFactory>)edgeFactory
{
    return [self.delegate edgeFactory];
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    return [self.delegate createEdgeFromVertex:sourceVertex toVertex:targetVertex];
}

- (BOOL)addEdge:(id)sourceVertex to:(id)targetVertex with:(id)edge
{
    return [self.delegate addEdge:sourceVertex to:targetVertex with:edge];
}

- (BOOL)addVertex:(id)vertex
{
    return [self.delegate addVertex:vertex];
}

- (BOOL)containsEdge:(id)edge
{
    return [self.delegate containsEdge:edge];
}

- (BOOL)containsVertex:(id)vertex
{
    return [self.delegate containsVertex:vertex];
}

- (NSInteger)degreeOf:(id)vertex
{
    return [self.delegate degreeOf:vertex];
}

- (NSArray *)edgeArray
{
    return [self.delegate edgeArray];
}

- (NSArray *)edgesOf:(id)vertex
{
    return [self.delegate edgesOf:vertex];
}

- (NSInteger)inDegreeOf:(id)vertex
{
    return [self.delegate inDegreeOf:vertex];
}

- (NSArray *)incomingEdgesOf:(id)vertex
{
    return [self.delegate incomingEdgesOf:vertex];
}

- (NSInteger)outDegreeOf:(id)vertex;
{
    return [self.delegate outgoingDegreeOf:vertex];
}

- (NSArray *)outgoingEdgesOf:(id)vertex
{
    return [self.delegate outgoingEdgesOf:vertex];
}

- (BOOL)removeEdge:(id)edge
{
    return [self.delegate removeEdge:edge];
}

- (BOOL)removeVertex:(id)vertex
{
    return [self.delegate removeVertex:vertex];
}

- (NSString *)description
{
    return [self.delegate description];
}

- (NSArray *)vertexArray
{
    return [self.delegate vertexArray];
}

- (id)edgeSource:(id)edge
{
    return [self.delegate edgeSource:edge];
}

- (id)edgeTarget:(id)edge
{
    return [self.delegate edgeTarget:edge];
}

- (double)edgeWeight:(id)edge
{
    return [self.delegate edgeWeight:edge];
}

- (void)setEdge:(id)edge withWeight:(double)weight
{
    [self.delegate setEdge:edge withWeight:weight];
}
@end
