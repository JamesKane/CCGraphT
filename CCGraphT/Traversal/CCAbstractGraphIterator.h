//
//  CCAbstractGraphIterator.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphIterator.h"
#import "CCTraversalListener.h"

@interface CCAbstractGraphIterator : NSObject <CCGraphIterator>
@property(strong, nonatomic) NSMutableArray *traversalListeners;
@property(nonatomic) BOOL crossComponentTraversal;
@property(nonatomic) BOOL reuseEvents;
@property(nonatomic) NSUInteger nListeners;

- (void)fireConnectedComponentFinished:(CCConnectedComponentTraversalEvent *)e;

- (void)fireConnectedComponentStarted:(CCConnectedComponentTraversalEvent *)e;

- (void)fireEdgeTraversed:(CCEdgeTraversalEvent *)e;

- (void)fireVertexTraversed:(CCVertexTraversalEvent *)e;

- (void)fireVertexFinished:(CCVertexTraversalEvent *)e;
@end
