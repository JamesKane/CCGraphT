//
//  CCGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCEdgeFactory.h"

@protocol CCGraph <NSObject>

- (NSArray *)allEdgesConnecting:(id)sourceVertex to:(id)targetVertex;

- (id)edgeConnecting:(id)sourceVertex to:(id)targetVertex;

- (id <CCEdgeFactory>)edgeFactory;

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex;

- (BOOL)addEdge:(id)edge fromVertex:(id)sourceVertex toVertex:(id)targetVertex;

- (BOOL)addVertex:(id)vertex;

- (BOOL)containsEdgeConnecting:(id)sourceVertex to:(id)targetVertex;

- (BOOL)containsEdge:(id)edge;

- (BOOL)containsVertex:(id)vertex;

- (NSArray *)edgeSet;

- (NSArray *)edgesOf:(id)vertex;

- (BOOL)removeEdgesInArray:(NSArray *)edges;

- (NSArray *)removeEdgesConnecting:(id)sourceVertex to:(id)targetVertex;

- (BOOL)removeVerticesInArray:(NSArray *)vertices;

- (id)removeEdgeConnecting:(id)sourceVertex to:(id)targetVertex;

- (BOOL)removeEdge:(id)edge;

- (BOOL)removeVertex:(id)vertex;

- (NSArray *)vertexSet;

- (id)edgeSource:(id)edge;

- (id)edgeTarget:(id)edge;

- (double)edgeWeight:(id)edge;

@end
