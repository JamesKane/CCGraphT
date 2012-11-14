//
//  CCAbstractBaseGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraph.h"
#import "CCEdgeSetFactory.h"

@class CCSpecifics;

@protocol CCSpecificsOwnerProtocol <NSObject>
- (BOOL)allowingLoops;
- (id <CCEdgeSetFactory>)edgeSetFactory;
@end

@interface CCAbstractBaseGraph : CCAbstractGraph <NSCopying, CCSpecificsOwnerProtocol>
- (id)initWithEF:(id<CCEdgeFactory>)ef allowingMultipleEdges:(BOOL)allowingMultipleEdges andLoops:(BOOL)allowingLoops;
- (void)setEdgeFactory:(id<CCEdgeFactory>)edgeFactory;
- (void)setEdgeSetFactory:(id<CCEdgeSetFactory>)edgeSetFactory;

// Implementing the CCDirectedGraph protocol but not explicitly advertising it for CC*Directed*Graph
- (NSInteger)inDegreeOf:(id)vertex;
- (NSSet *)incomingEdgesOf:(id)vertex;
- (NSInteger)outgoingDegreeOf:(id)vertex;
- (NSSet *)outgoingEdgesOf:(id)vertex;

- (void)setEdge:(id)edge withWeight:(double)weight;

- (CCSpecifics *)createSpecifics;
@end

#pragma mark --
#pragma mark Private classes

@interface CCEdgeSetFactory : NSObject
@end

@interface CCSpecifics : NSObject
@property (weak, nonatomic) id <CCSpecificsOwnerProtocol> delegate;
- (NSSet *)allEdges:(id)sourceVertex to:(id)targetVertex;
- (id)getEdge:(id)sourceVertex to:(id)targetVertex;
- (void)addEdgeToTouchingVertices:(id)edge;
- (void)addVertex:(id)vertex;
- (NSSet *)vertexSet;
- (NSSet *)edgesOf:(id)vertex;
- (NSInteger)degreeOf:(id)vertex;
- (NSInteger)inDegreeOf:(id)vertex;
- (NSSet *)incomingEdgesOf:(id)vertex;
- (NSInteger)outgoingDegreeOf:(id)vertex;
- (NSSet *)outgoingEdgesOf:(id)vertex;
- (void)removeEdgeFromTouchingVertices:(id)edge;
- (void)removeVertex:(id)vertex;
- (BOOL)containsVertex:(id)vertex;
- (id)edgeSource:(id)edge;
- (id)edgeTarget:(id)edge;
- (BOOL)assertVertexExists:(id)vertex;
@end

@interface CCDirectedSpecifics : CCSpecifics
@property (strong, nonatomic) NSMutableDictionary *vertexMapDirected;
@end

@interface CCUndirectedSpecifics : CCSpecifics
@property (strong, nonatomic) NSMutableDictionary *vertexMapUndirected;
@end

@interface CCDirectedEdgeContainer : NSObject
@property (strong, nonatomic) NSMutableSet *incoming;
@property (strong, nonatomic) NSMutableSet *outgoing;
@property (strong, nonatomic, readonly) NSSet *unmodifiableIncoming;
@property (strong, nonatomic, readonly) NSSet *unmbodifableOutgoing;

- (id)initWithFactory:(id <CCEdgeSetFactory>)edgeSetFactory for:(id)vertex;
- (void)addIncomingEdge:(id)e;
- (void)addOutgoingEdge:(id)e;
- (void)removeIncomingEdge:(id)e;
- (void)removeOutgoingEdge:(id)e;
@end

@interface CCUndirectedEdgeContainer : NSObject
@property (strong, nonatomic) NSMutableSet *vertexEdges;
@property (strong, nonatomic, readonly) NSSet *unmodifiableVertexEdges;

- (id)initWithFactory:(id <CCEdgeSetFactory>)edgeSetFactory for:(id)vertex;
- (void)addEdge:(id)edge;
- (void)removeEdge:(id)edge;
- (NSUInteger)count;
@end

@interface CCArrayListFactory : NSObject <CCEdgeSetFactory>
@end

@class TypeUtil;