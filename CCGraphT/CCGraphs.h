//
//  CCGraphs.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGraph.h"
#import "CCDirectedGraph.h"
#import "CCWeightedGraph.h"
#import "CCGraphPath.h"

@interface CCGraphs : NSObject
+ (id)createEdgeInGraph:(id<CCGraph>)g from:(id)sourceVertex to:(id)targetVertex withWeight:(double)weight;
+ (id)createEdgeInGraph:(id<CCGraph>)g adding:(id)sourceVertex to:(id)targetVertex withWeight:(double)weight;
+ (id)addEdge:(id)e toGraph:(id<CCGraph>)g from:(id)sourceVertex to:(id)targetVertex;
+ (BOOL)addEdge:(id)edge fromGraph:(id<CCGraph>)sourceGraph toGraph:(id<CCGraph>)targetGraph;
+ (BOOL)addToGraph:(id<CCGraph>)destination fromGraph:(id<CCGraph>)source;
+ (void)addReversedToGraph:(id<CCGraph>)destination fromGraph:(id<CCGraph>)source;
+ (BOOL)addAllVerticesToGraph:(id<CCGraph>)destination fromSet:(NSSet *)vertices;
+ (BOOL)addAllEdgesToGraph:(id<CCGraph>)destination fromGraph:(id<CCGraph>)source inSet:(NSSet *)edges;
+ (id)oppositeVertex:(id<CCGraph>)graph for:(id)edge from:(id)vertex;

+ (NSArray *)predecessorsListOf:(id)vertex inGraph:(id<CCDirectedGraph>)g;
+ (NSArray *)successorListOf:(id)vertex inGraph:(id<CCDirectedGraph>)g;

+ (BOOL)testEdge:(id)e isIncident:(id)v inGraph:(id<CCGraph>)g;

+ (id)oppositeVertexInEdge:(id)edge fromVertex:(id)vertex inGraph:(id<CCDirectedGraph>)g;
+ (NSArray *)pathVertexList:(id<CCGraphPath>)path;
@end
