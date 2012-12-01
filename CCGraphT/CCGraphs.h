//
//  CCGraphs.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraph.h"
#import "CCDirectedGraph.h"
#import "CCWeightedGraph.h"
#import "CCGraphPath.h"

@interface CCGraphs : NSObject
+ (id)createEdgeInGraph:(id <CCGraph>)g fromVertex:(id)sourceVertex toVertex:(id)targetVertex withWeight:(double)weight;

+ (id)createEdgeInGraph:(id <CCGraph>)g addingVertex:(id)sourceVertex toVertex:(id)targetVertex withWeight:(double)weight;

+ (id)addEdge:(id)e toGraph:(id <CCGraph>)g fromVertex:(id)sourceVertex toVertex:(id)targetVertex;

+ (BOOL)addEdge:(id)edge fromGraph:(id <CCGraph>)sourceGraph toGraph:(id <CCGraph>)targetGraph;

+ (BOOL)addAllElementsToGraph:(id <CCGraph>)destination fromGraph:(id <CCGraph>)source;

+ (void)addReversedElementsToGraph:(id <CCGraph>)destination fromGraph:(id <CCGraph>)source;

+ (BOOL)addAllVerticesToGraph:(id <CCGraph>)destination fromArray:(NSArray *)vertices;

+ (BOOL)addAllEdgesToGraph:(id <CCGraph>)destination fromGraph:(id <CCGraph>)source fromArray:(NSArray *)edges;

+ (id)oppositeVertexInGraph:(id <CCGraph>)graph forEdge:(id)edge fromVertex:(id)vertex;

+ (NSArray *)predecessorsListOfVertex:(id)vertex inGraph:(id <CCDirectedGraph>)g;

+ (NSArray *)successorListOfVertex:(id)vertex inGraph:(id <CCDirectedGraph>)g;

+ (BOOL)testEdge:(id)e isIncidentVertex:(id)v inGraph:(id <CCGraph>)g;

+ (id)oppositeVertexInEdge:(id)edge fromVertex:(id)vertex inGraph:(id <CCGraph>)g;

+ (NSArray *)pathVertexList:(id <CCGraphPath>)path;
@end
