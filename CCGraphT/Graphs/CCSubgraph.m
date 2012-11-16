//
//  CCSubgraph.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCSubgraph.h"
#import "CCAbstractBaseGraph.h"

@interface CCSubgraph ()
@property (strong, nonatomic) NSArray *unmodifiableEdgeSet;
@property (strong, nonatomic) NSArray *unmodifiableVertexSet;
@property (weak, nonatomic) CCAbstractBaseGraph *graph;
@property (nonatomic) BOOL induced;
@end

@implementation CCSubgraph



@end
