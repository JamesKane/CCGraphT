//
//  CCCrossComponentIterator.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraphIterator.h"
#import "CCAbstractBaseGraph.h"
#import "CCEdgeTraversalEvent.h"
#import "CCVertexTraversalEvent.h"

@class CCFlyweightEdgeEvent;
@class CCFlyweightVertexEvent;

typedef enum CCS_COMPONENT_STATE {
    CCS_BEFORE_COMPONENT = 1,
    CCS_WITHIN_COMPONENT = 2,
    CCS_AFTER_COMPONENT = 3
} CCSComponentState;

typedef enum CCI_VISIT_COLOR {
    WHITE,
    GRAY,
    BLACK
} VisitColor;

@interface CCGraphIteratorEdgeProvider : NSObject
@property(strong, readonly, nonatomic) CCAbstractBaseGraph *graph;

- (id)initWith:(id <CCGraph>)graph;

- (NSArray *)edgesOf:(id)vertex;
@end

@interface CCDirectedGraphEdgeProvider : CCGraphIteratorEdgeProvider
@end

@interface CCUndirectedGraphEdgeProvider : CCGraphIteratorEdgeProvider
@end

@interface CCCrossComponentIterator : CCAbstractGraphIterator
@property(strong, nonatomic) CCConnectedComponentTraversalEvent *ccFinishedEvent;
@property(strong, nonatomic) CCConnectedComponentTraversalEvent *ccStartedEvent;
@property(strong, nonatomic) CCFlyweightEdgeEvent *reusableEdgeEvent;
@property(strong, nonatomic) CCFlyweightVertexEvent *reusableVertexEvent;
@property(strong, nonatomic) NSEnumerator *vertexIterator;

@property(strong, nonatomic) NSMutableDictionary *seen;
@property(strong, nonatomic) id startVertex;
@property(strong, nonatomic) CCGraphIteratorEdgeProvider *specifics;

@property(weak, nonatomic) CCAbstractBaseGraph *graph;

@property(nonatomic) CCSComponentState state;

- (id)initWithGraph:(CCAbstractBaseGraph *)graph startFrom:(id)startVertex;

- (CCSpecifics *)createGraphSpecifics:(CCAbstractGraph *)graph;

- (BOOL)isConnectedComponentExhausted;

- (id)provideNextVertex;

- (void)encounterStartVertex;

- (void)addUnseenChildrenOf:(id)vertex;

- (BOOL)isSeenVertex:(id)vertex;

- (void)encounterVertex:(id)vertex with:(id)edge;

- (void)encounterVertexAgain:(id)vertex with:(id)edge;

- (id)seenData:(id)vertex;

- (id)putSeenData:(id)data withKey:(id)vertex;

- (void)finishVertex:(id)vertex;

- (CCVertexTraversalEvent *)createVertexTraversalEvent:(id)vertex;

- (CCEdgeTraversalEvent *)createEdgeTraversalEvent:(id)edge;
@end

@interface CCFlyweightEdgeEvent : CCEdgeTraversalEvent
@property(strong, nonatomic) id edge;
@end

@interface CCFlyweightVertexEvent : CCVertexTraversalEvent
@property(strong, nonatomic) id vertex;
@end
