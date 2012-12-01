//
//  CCClosestFirstIterator.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCCrossComponentIterator.h"

@class CCFibonacciHeapNode;

@interface CCClosestFirstIterator : CCCrossComponentIterator
- (id)initWithGraph:(CCAbstractBaseGraph *)graph;

- (id)initWithGraph:(CCAbstractGraph *)graph startFrom:(id)startVertex withRadius:(double)radius;

- (void)checkRadiusTraversal:(BOOL)crossComponentTraversal;

- (double)shortestPathLength:(id)vertex;

- (id)spanningTreeEdge:(id)vertex;

- (double)calculatePathLength:(id)vertex on:(id)edge;

- (CCFibonacciHeapNode *)createSeenData:(id)vertex on:(id)edge;
@end

@interface CCQueueEntry : NSObject
@property(strong, nonatomic) id spanningTreeEdge;
@property(strong, nonatomic) id vertex;
@property(nonatomic) BOOL frozen;
@end
