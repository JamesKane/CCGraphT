//
//  CCDirectedMultigraph.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDirectedMultigraph.h"
#import "CCClassBasedEdgeFactory.h"

@implementation CCDirectedMultigraph

- (id)initWithEdgeFactory:(id<CCEdgeFactory>)ef
{
    return [super initWithEF:ef allowingMultipleEdges:YES andLoops:YES];
}

- (id)initWithEdgeClass:(Class)edgeClass
{
    return [self initWithEdgeFactory:[[CCClassBasedEdgeFactory alloc] initWithEdgeClass:edgeClass]];
}

@end
