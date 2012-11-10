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

- (NSSet *)allEdges:(id)sourceVertex to:(id)targetVertex;

- (id)getEdge:(id)sourceVertex to:(id)targetVertex;

- (id<CCEdgeFactory>)edgeFactory;

- (id)addEdge:(id)sourceVertex to:(id)targetVertex;

- (BOOL)addEdge:(id)sourceVertex to:(id)targetVertex with:(id)edge;

- (BOOL)addVertex:(id)vertex;

- (BOOL)containsEdge:(id)sourceVertex to:(id)targetVertex;

- (BOOL)containsEdge:(id)edge;

- (BOOL)containsVertex:(id)vertex;

- (NSSet *)edgeSet;

- (NSSet *)edgesOf:(id)vertex;

- (BOOL)removeAllEdges:(NSArray *)edges;

- (NSSet *)removeAllEdges:(id)sourceVertex to:(id)targetVertex;

- (BOOL)removeAllVertices:(NSArray *)vertices;

- (id)removeEdge:(id)sourceVertex to:(id)targetVertex;

- (BOOL)removeEdge:(id)edge;

- (BOOL)removeVertex:(id)vertex;

- (NSSet *)vertexSet;

- (id)edgeSource:(id)edge;

- (id)edgeTarget:(id)edge;

- (double)edgeWeight:(id)edge;

@end
