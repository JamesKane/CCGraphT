//
//  CCDefaultDirectedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDefaultDirectedGraph.h"
#import "CCClassBasedEdgeFactory.h"

@implementation CCDefaultDirectedGraph

- (id)initWithEdgeClass:(Class)edgeClass
{
    return [self initWithEdgeFactory:[[CCClassBasedEdgeFactory alloc] initWithEdgeClass:edgeClass]];
}

- (id)initWithEdgeFactory:(id<CCEdgeFactory>)ef
{
    if (self = [super initWithEF:ef allowingMultipleEdges:NO andLoops:YES]) {
        
    }
    return self;
}
@end
