//
//  CCSubgraph.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraph.h"

@class CCAbstractBaseGraph;

@interface CCSubgraph : CCAbstractGraph
@property (strong, nonatomic) NSMutableArray *edgeSet;
@property (strong, nonatomic) NSMutableArray *vertexSet;

- (id)initWithGraph:(CCAbstractBaseGraph *)base usingVertexSubset:(NSArray *)vertexSet andEdgeSubset:(NSArray *)edgeSubset;
- (id)initWithGraph:(CCAbstractBaseGraph *)base usingVertexSubset:(NSArray *)vertexSet;

@end
