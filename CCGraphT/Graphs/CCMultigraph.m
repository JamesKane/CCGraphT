//
//  CCMultigraph.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCMultigraph.h"
#import "CCClassBasedEdgeFactory.h"

@implementation CCMultigraph

- (id)initWithEdgeClass:(Class)edgeClass
{
    return [self initWithEdgeFactory:[[CCClassBasedEdgeFactory alloc] initWithEdgeClass:edgeClass]];
}

- (id)initWithEdgeFactory:(id<CCEdgeFactory>)ef
{
    self = [super initWithEF:ef allowingMultipleEdges:true andLoops:false];
    return self;
}

@end
