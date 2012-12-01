//
//  CCSimpleGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCSimpleGraph.h"
#import "CCClassBasedEdgeFactory.h"

@implementation CCSimpleGraph
- (id)initWithEdgeClass:(Class)edgeClass {
    return [self initWithEdgeFactory:[[CCClassBasedEdgeFactory alloc] initWithEdgeClass:edgeClass]];
}

- (id)initWithEdgeFactory:(id <CCEdgeFactory>)ef {
    self = [super initWithEF:ef allowingMultipleEdges:NO andLoops:NO];
    return self;
}
@end
