//
//  CCTraversalListener.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCConnectedComponentTraversalEvent;
@class CCEdgeTraversalEvent;
@class CCVertexTraversalEvent;

@protocol CCTraversalListener <NSObject>
- (void)connectedComponentFinished:(CCConnectedComponentTraversalEvent *)e;

- (void)connectedComponentStarted:(CCConnectedComponentTraversalEvent *)e;

- (void)edgeTraversed:(CCEdgeTraversalEvent *)e;

- (void)vertexTraversed:(CCVertexTraversalEvent *)e;

- (void)vertexFinished:(CCVertexTraversalEvent *)e;
@end
