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
@property (strong, nonatomic) NSMutableSet *edgeSet;
@property (strong, nonatomic) NSMutableSet *vertexSet;

- (id)initWithGraph:(CCAbstractBaseGraph *)base usingVertexSubset:(NSSet *)vertexSet andEdgeSubset:(NSSet *)edgeSubset;
- (id)initWithGraph:(CCAbstractBaseGraph *)base usingVertexSubset:(NSSet *)vertexSet;

@end
