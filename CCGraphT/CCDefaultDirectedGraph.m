//
//  CCDefaultDirectedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDefaultDirectedGraph.h"
#import "CCClassBasedEdgeFactory.h"

@implementation CCDefaultDirectedGraph

- (id)initWithEdgeFactory:(id <CCEdgeFactory>)ef {
    if (self = [super initWithEF:ef allowingMultipleEdges:NO andLoops:YES]) {

    }
    return self;
}

- (id)initWithEdgeClass:(Class)edgeClass {
    return [self initWithEdgeFactory:[[CCClassBasedEdgeFactory alloc] initWithEdgeClass:edgeClass]];
}
@end
