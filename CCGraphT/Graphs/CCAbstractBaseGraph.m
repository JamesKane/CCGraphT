//
//  CCAbstractBaseGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractBaseGraph.h"
#import "CCDirectedGraph.h"
#import "CCUndirectedGraph.h"
#import "CCWeightedGraph.h"
#import "CCGraphs.h"
#import "CCDefaultWeightedEdge.h"
#import "CCOrderedDictionary.h"

#define ABG_LOOPS_NOT_ALLOWED @"loops not allowed"

@interface CCAbstractBaseGraph ()
@property (strong, nonatomic) id<CCEdgeFactory> edgeFactory;
@property (strong, nonatomic) id<CCEdgeSetFactory> edgeSetFactory;
@property (strong, nonatomic) CCOrderedDictionary *edgeMap;
@property (strong, nonatomic) NSArray *unmodifiableEdgeArray;
@property (strong, nonatomic) NSArray *unmodifiableVertexArray;
@property (strong, nonatomic) CCSpecifics *specifics;
@property (nonatomic) BOOL allowingMultipleEdges;
@property (nonatomic) BOOL allowingLoops;
@end

#pragma mark --
#pragma mark CCAbstractBaseGraph class implementation

@implementation CCAbstractBaseGraph
@synthesize edgeFactory = _edgeFactory;
@synthesize edgeSetFactory = _edgeSetFactory;
@synthesize edgeMap = _edgeMap;
@synthesize unmodifiableEdgeArray = _unmodifiableEdgeArray;
@synthesize unmodifiableVertexArray = _unmodifiableVertexArray;
@synthesize specifics = _specifics;
@synthesize allowingMultipleEdges = _allowingMultipleEdges;
@synthesize allowingLoops = _allowingLoops;

- (id)initWithEF:(id<CCEdgeFactory>)ef allowingMultipleEdges:(BOOL)allowingMultipleEdges andLoops:(BOOL)allowingLoops
{
    if ((self = [super init])) {
        self.edgeMap = [CCOrderedDictionary dictionary];
        self.edgeFactory = ef;
        self.allowingLoops = allowingLoops;
        self.allowingMultipleEdges = allowingMultipleEdges;
        
        self.specifics = [self createSpecifics];
        self.edgeSetFactory = [[CCArrayListFactory alloc] init];
    }
    return self;
}

#pragma mark --
#pragma mark Graph methods

- (BOOL)assertVertexExists:(id)vertex
{
    return [self.specifics assertVertexExists:vertex];
}

- (NSArray *)allEdgesConnecting:(id)sourceVertex to:(id)targetVertex
{
    return [self.specifics allEdges:sourceVertex to:targetVertex];
}

- (BOOL)isAllowingLoops
{
    return self.allowingLoops;
}

- (BOOL)isAllowingMultipleEdges
{
    return self.allowingMultipleEdges;
}

- (id)edgeConnecting:(id)sourceVertex to:(id)targetVertex
{
    return [self.specifics getEdge:sourceVertex to:targetVertex];
}

- (void)setEdgeFactory:(id<CCEdgeFactory>)edgeFactory
{
    _edgeFactory = edgeFactory;
}

- (void)setEdgeSetFactory:(id<CCEdgeSetFactory>)edgeSetFactory
{
    _edgeSetFactory = edgeSetFactory;
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    [self assertVertexExists:sourceVertex];
    [self assertVertexExists:targetVertex];
    
    if (!self.allowingMultipleEdges && [self containsEdgeConnecting:sourceVertex to:targetVertex]) {
        return nil;
    }
    
    if (!self.allowingLoops && [sourceVertex isEqual:targetVertex]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:ABG_LOOPS_NOT_ALLOWED userInfo:nil];
    }
    
    id e = [self.edgeFactory createEdgeFromVertex:sourceVertex toVertex:targetVertex];
    
    if ([self containsEdge:e]) {
        return nil;
    } else {
        CCIntrusiveEdge *edge = [self createInstrusiveEdge:e from:sourceVertex to:targetVertex];
        [self.edgeMap setObject:edge forKey:e];
        [self.specifics addEdgeToTouchingVertices:e];
    }
    
    return e;
}

- (BOOL)addEdge:(id)edge fromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    if (edge == nil)
        @throw [NSException exceptionWithName:@"NilPointerException" reason:@"graph cannot contain nil edge" userInfo:nil];
    if ([self containsEdge:edge])
        return NO;

    [self assertVertexExists:targetVertex];
    [self assertVertexExists:sourceVertex];
    
    if (!self.allowingMultipleEdges && [self containsEdgeConnecting:sourceVertex to:targetVertex]) {
        return NO;
    }
    
    if (!self.allowingLoops && [targetVertex isEqual:sourceVertex]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:ABG_LOOPS_NOT_ALLOWED userInfo:nil];
    }
    
    CCIntrusiveEdge *e = [self createInstrusiveEdge:edge from:sourceVertex to:targetVertex];
    [self.edgeMap setObject:edge forKey:e];
    [self.specifics addEdgeToTouchingVertices:e];
    self.unmodifiableEdgeArray = nil;
    
    return YES;
}

- (CCIntrusiveEdge *)createInstrusiveEdge:(id)edge from:(id)sourceVertex to:(id)targetVertex
{
    CCIntrusiveEdge *intrusiveEdge;
    if ([edge isKindOfClass:[CCIntrusiveEdge class]]) {
        intrusiveEdge = (CCIntrusiveEdge *)edge;
    } else {
        intrusiveEdge = [[CCIntrusiveEdge alloc] init];
    }
    intrusiveEdge.source = sourceVertex;
    intrusiveEdge.target = targetVertex;
    
    return intrusiveEdge;
}

- (BOOL)addVertex:(id)vertex
{
    if (vertex == nil)
        @throw [NSException exceptionWithName:@"NilPointerException" reason:@"graph cannot contain a nil vertex" userInfo:nil];
    else if([self containsVertex:vertex])
        return NO;
    
    [self.specifics addVertex:vertex];
    self.unmodifiableVertexArray = nil;     // Invalidate the cached array
    return YES;
}

- (id)edgeSource:(id)edge
{
    return [self intrusiveEdge:edge].source;
}

- (id)edgeTarget:(id)edge
{
    return [self intrusiveEdge:edge].target;
}

- (CCIntrusiveEdge *)intrusiveEdge:(id)edge
{
    if ([edge isKindOfClass:[CCIntrusiveEdge class]]) {
        return edge;
    }
    
    return [self.edgeMap objectForKey:edge];
}

- (BOOL)containsEdge:(id)edge
{
    return [self.edgeMap objectForKey:edge] != nil;
}

- (BOOL)containsVertex:(id)vertex
{
    return [[self.specifics vertexArray] containsObject:vertex];
}

- (NSInteger)degreeOf:(id)vertex
{
    return [self.specifics degreeOf:vertex];
}

- (NSArray *)edgeSet
{
    if (self.unmodifiableEdgeArray == nil) {
        self.unmodifiableEdgeArray = [NSArray arrayWithArray:[self.edgeMap allKeys]];
    }
    
    return self.unmodifiableEdgeArray;
}

- (NSArray *)edgesOf:(id)vertex
{
    return [self.specifics edgesOf:vertex];
}

- (NSInteger)inDegreeOf:(id)vertex
{
    return [self.specifics inDegreeOf:vertex];
}

- (NSArray *)incomingEdgesOf:(id)vertex
{
    return [self.specifics incomingEdgesOf:vertex];
}

- (NSInteger)outgoingDegreeOf:(id)vertex
{
    return [self.specifics outgoingDegreeOf:vertex];
}

- (NSArray *)outgoingEdgesOf:(id)vertex
{
    return [self.specifics outgoingEdgesOf:vertex];
}

- (id)removeEdgeConnecting:(id)sourceVertex to:(id)targetVertex
{
    id e = [self edgeConnecting:sourceVertex to:targetVertex];
    
    if (e != nil) {
        [self.specifics removeEdgeFromTouchingVertices:e];
        [self.edgeMap removeObjectForKey:e];
        self.unmodifiableEdgeArray = nil;
    }
    
    return e;
}

- (BOOL)removeEdge:(id)edge
{
    if ([self containsEdge:edge]) {
        [self.specifics removeEdgeFromTouchingVertices:edge];
        [self.edgeMap removeObjectForKey:edge];
        self.unmodifiableEdgeArray = nil;
        return YES;
    }
    
    return NO;
}

- (BOOL)removeVertex:(id)vertex
{
    if ([self containsVertex:vertex]) {
        NSArray *touchingEdgesList = [self edgesOf:vertex];
        [self removeEdgesInArray:touchingEdgesList];
        [self.specifics removeVertex:vertex];
        self.unmodifiableVertexArray = nil;
        return YES;
    }
    
    return NO;
}

- (NSArray *)vertexSet
{
    if (self.unmodifiableVertexArray == nil) {
        self.unmodifiableVertexArray = [NSArray arrayWithArray:[self.specifics vertexArray]];
    }
    
    return self.unmodifiableVertexArray;
}

- (double)edgeWeight:(id)edge
{
    if ([edge isKindOfClass:[CCDefaultWeightedEdge class]]) {
        return ((CCDefaultWeightedEdge *)edge).weight;
    }
    return WG_DEFAULT_EDGE_WEIGHT;
}

- (void)setEdge:(id)edge withWeight:(double)weight
{
    if ([edge isKindOfClass:[CCDefaultWeightedEdge class]]) {
        ((CCDefaultWeightedEdge *)edge).weight = weight;
    }
}

- (CCSpecifics *)createSpecifics
{
    if ([self conformsToProtocol:@protocol(CCDirectedGraph)]) {
        CCDirectedSpecifics *s = [[CCDirectedSpecifics alloc] init];
        s.delegate = self;
        return s;
    } else if([self conformsToProtocol:@protocol(CCUndirectedGraph)]) {
        CCUndirectedSpecifics *s = [[CCUndirectedSpecifics alloc] init];
        s.delegate = self;
        return s;
    } else {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"must conform either DirectedGraph or UndirectedGraph" userInfo:nil];
    }
}

#pragma mark --
#pragma mark NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
{
    CCAbstractBaseGraph *newGraph = [super copy];
    
    newGraph.edgeMap = [NSDictionary dictionary];
    
    newGraph.edgeFactory = self.edgeFactory;
    newGraph.unmodifiableEdgeArray = nil;
    newGraph.unmodifiableVertexArray = nil;
    
    newGraph.specifics = [newGraph createSpecifics];
    
    [CCGraphs addAllElementsToGraph:newGraph fromGraph:self];
    
    return newGraph;
}
@end

#pragma mark --
#pragma mark CCArrayListFactory

@implementation CCArrayListFactory

- (NSMutableArray *)createEdgeSet:(id)vertex
{
    return [NSMutableArray array];
}

@end

#pragma mark --
#pragma mark CCSpecfics class implementation

@implementation CCSpecifics
@synthesize delegate = _delegate;

- (BOOL)assertVertexExists:(id)vertex
{
    if ([self containsVertex:vertex]) {
        return YES;
    } else if (vertex == nil) {
        @throw [NSException exceptionWithName:@"NilPointerException" reason:@"Graph vertex cannot contain a nil pointer" userInfo:nil];
    } else {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"No such vertex in graph" userInfo:nil];
    }
}

- (id)edgeSource:(id)edge
{
    if ([edge respondsToSelector:@selector(source)]) {
        return [edge performSelector:@selector(source)];
    }
    return nil;
}

- (id)edgeTarget:(id)edge
{
    if ([edge respondsToSelector:@selector(target)]) {
        return [edge performSelector:@selector(target)];
    }
    return nil;
}

- (BOOL)containsVertex:(id)vertex
{
    return [self getEdgeContainer:vertex] != nil;
}

// 'Abstract' methods
- (id)getEdgeContainer:(id)vertex { return nil; }
- (NSArray *)allEdges:(id)sourceVertex to:(id)targetVertex { return nil; }
- (id)getEdge:(id)sourceVertex to:(id)targetVertex { return nil; }
- (void)addEdgeToTouchingVertices:(id)edge {}
- (void)addVertex:(id)vertex {}
- (NSArray *)vertexArray { return nil; }
- (NSArray *)edgesOf:(id)vertex { return nil; }
- (NSInteger)degreeOf:(id)vertex { return -1; }
- (NSInteger)inDegreeOf:(id)vertex { return -1; }
- (NSArray *)incomingEdgesOf:(id)vertex { return nil; }
- (NSInteger)outgoingDegreeOf:(id)vertex { return -1; }
- (NSArray *)outgoingEdgesOf:(id)vertex { return nil; }
- (void)removeEdgeFromTouchingVertices:(id)edge {}
- (void)removeVertex:(id)vertex {}
@end

#pragma mark --
#pragma mark CCDirectedGraphContainer class implementation

@implementation CCDirectedEdgeContainer
@synthesize incoming = _incoming;
@synthesize outgoing = _outgoing;
@synthesize unmodifiableIncoming = _unmodifiableIncoming;
@synthesize unmbodifableOutgoing = _unmbodifableOutgoing;

- (id)initWithFactory:(id<CCEdgeSetFactory>)edgeSetFactory for:(id)vertex
{
    if ((self = [super init])) {
        self.incoming = [edgeSetFactory createEdgeSet:vertex];
        self.outgoing = [edgeSetFactory createEdgeSet:vertex];
    }
    return self;
}

- (NSArray *)unmodifiableIncoming
{
    if (_unmodifiableIncoming == nil) {
        _unmodifiableIncoming = [NSArray arrayWithArray:self.incoming];
    }
    return _unmodifiableIncoming;
}

- (NSArray *)unmbodifableOutgoing
{
    if (_unmbodifableOutgoing == nil) {
        _unmbodifableOutgoing = [NSArray arrayWithArray:self.outgoing];
    }
    return _unmbodifableOutgoing;
}

- (void)addIncomingEdge:(id)e
{
    [self.incoming addObject:e];
}

- (void)addOutgoingEdge:(id)e
{
    [self.outgoing addObject:e];
}

- (void)removeIncomingEdge:(id)e
{
    [self.incoming removeObject:e];
}

- (void)removeOutgoingEdge:(id)e
{
    [self.outgoing removeObject:e];
}
@end

#pragma mark --
#pragma mark CCDirectedSpecifics class implementation

@implementation CCDirectedSpecifics
@synthesize vertexMapDirected = _vertexMapDirected;

- (id)init
{
    if ((self = [super init])) {
        self.vertexMapDirected = [CCOrderedDictionary dictionary];
    }
    return self;
}

- (void)addVertex:(id)vertex
{
    [self.vertexMapDirected setObject:[NSNull null] forKey:vertex];
}

- (void)removeVertex:(id)vertex
{
    [self.vertexMapDirected removeObjectForKey:vertex];
}

- (NSArray *)vertexArray
{
    return [NSArray arrayWithArray:[self.vertexMapDirected allKeys]];
}

- (NSArray *)allEdges:(id)sourceVertex to:(id)targetVertex
{
    NSMutableArray *edges = nil;
    
    if ([self containsVertex:sourceVertex] && [self containsVertex:targetVertex]) {
        edges = [NSMutableArray array];
        
        CCDirectedEdgeContainer *ec = [self getEdgeContainer:sourceVertex];
        
        for (id e in ec.outgoing) {
            if ([[self edgeTarget:e] isEqual:targetVertex]) {
                [edges addObject:e];
            }
        }
    }
    
    return [NSArray arrayWithArray:edges];
}

- (NSArray *)getEdge:(id)sourceVertex to:(id)targetVertex
{
    if ([self containsVertex:sourceVertex] && [self containsVertex:targetVertex]) {
        CCDirectedEdgeContainer *ec = [self getEdgeContainer:sourceVertex];
        
        for (id e in ec.outgoing) {
            if ([[self edgeTarget:e] isEqual:targetVertex]) {
                return e;
            }
        }
    }
    
    return nil;
}

- (void)addEdgeToTouchingVertices:(id)edge
{
    id source = [self edgeSource:edge];
    id target = [self edgeTarget:edge];
    
    [[self getEdgeContainer:source] addOutgoingEdge:edge];
    [[self getEdgeContainer:target] addIncomingEdge:edge];
}

- (NSInteger)degreeOf:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:@"no such operation in a directed graph" userInfo:nil];
}

- (NSArray *)edgesOf:(id)vertex
{
    NSMutableArray *inAndOut = [NSMutableArray arrayWithArray:((CCDirectedEdgeContainer *)[self getEdgeContainer:vertex]).incoming];
    [inAndOut addObjectsFromArray:((CCDirectedEdgeContainer *)[self getEdgeContainer:vertex]).outgoing];
    
    if ([self.delegate allowingLoops]) {
        NSMutableArray *loops = [NSMutableArray arrayWithArray:[self allEdges:vertex to:vertex]];
        
        for (NSUInteger i = 0; i < [inAndOut count]; ) {
            id e = [inAndOut objectAtIndex:i];
            
            if([loops containsObject:e]) {
                [inAndOut removeObjectAtIndex:i];
                [loops removeObject:e];
            } else {
                i++;
            }
        }
    }
    
    return [NSArray arrayWithArray:inAndOut];
}

- (NSInteger)inDegreeOf:(id)vertex
{
    return [[self getEdgeContainer:vertex].incoming count];
}

- (NSArray *)incomingEdgesOf:(id)vertex
{
    return [self getEdgeContainer:vertex].unmodifiableIncoming;
}

- (NSInteger)outgoingDegreeOf:(id)vertex
{
    return [[self getEdgeContainer:vertex].outgoing count];
}

- (NSArray *)outgoingEdgesOf:(id)vertex
{
    return [self getEdgeContainer:vertex].unmbodifableOutgoing;
}

- (void)removeEdgeFromTouchingVertices:(id)edge
{
    id source = [self edgeSource:edge];
    id target = [self edgeTarget:edge];
    
    [[self getEdgeContainer:source] removeOutgoingEdge:edge];
    [[self getEdgeContainer:target] removeIncomingEdge:edge];
}

- (CCDirectedEdgeContainer *)getEdgeContainer:(id)vertex
{
    CCDirectedEdgeContainer *ec = [self.vertexMapDirected objectForKey:vertex];
    
    if ((NSNull *)ec == [NSNull null]) {
        ec = [[CCDirectedEdgeContainer alloc] initWithFactory:[self.delegate edgeSetFactory] for:vertex];
        [self.vertexMapDirected setObject:ec forKey:vertex];
    }
    
    return ec;
}
@end

#pragma mark --
#pragma mark CCUndirectedGraphContainer class implementation

@implementation CCUndirectedEdgeContainer
@synthesize vertexEdges = _vertexEdges;
@synthesize unmodifiableVertexEdges = _unmodifiableVertexEdges;

- (id)initWithFactory:(id<CCEdgeSetFactory>)edgeSetFactory for:(id)vertex
{
    if ((self = [super init])) {
        self.vertexEdges = [edgeSetFactory createEdgeSet:vertex];
    }
    return self;
}

- (NSArray *)unmodifiableVertexEdges
{
    if (_unmodifiableVertexEdges == nil) {
        _unmodifiableVertexEdges = [NSArray arrayWithArray:self.vertexEdges];
    }
    return _unmodifiableVertexEdges;
}

- (void)addEdge:(id)edge
{
    [self.vertexEdges addObject:edge];
}

- (void)removeEdge:(id)edge
{
    [self.vertexEdges removeObject:edge];
}

- (NSUInteger)count
{
    return [self.vertexEdges count];
}
@end

#pragma mark --
#pragma mark CCUndirectedSpecifics class implementation

@implementation CCUndirectedSpecifics
@synthesize vertexMapUndirected = _vertexMapUndirected;

- (id)init
{
    if (self = [super init]) {
        self.vertexMapUndirected = [CCOrderedDictionary dictionary];
    }
    return self;
}

- (void)addVertex:(id)vertex
{
    [self.vertexMapUndirected setObject:[NSNull null] forKey:vertex];
}

- (void)removeVertex:(id)vertex
{
    [self.vertexMapUndirected removeObjectForKey:vertex];
}

- (NSArray *)vertexArray
{
    return [NSArray arrayWithArray:[self.vertexMapUndirected allKeys]];
}

- (NSArray *)allEdges:(id)sourceVertex to:(id)targetVertex
{
    NSMutableArray *edges = nil;
    
    if ([self containsVertex:sourceVertex] && [self containsVertex:targetVertex]) {
        edges = [NSMutableArray array];
        
        for (id e in [self getEdgeContainer:sourceVertex].vertexEdges) {
            BOOL equalStraight = [sourceVertex isEqual:[self edgeSource:e]] && [targetVertex isEqual:[self edgeTarget:e]];
            BOOL equalInverted = [sourceVertex isEqual:[self edgeTarget:e]] && [targetVertex isEqual:[self edgeSource:e]];
            
            if (equalStraight || equalInverted) {
                [edges addObject:e];
            }
        }
    }
    
    return [NSArray arrayWithArray:edges];
}

- (id)getEdge:(id)sourceVertex to:(id)targetVertex
{
    if ([self containsVertex:sourceVertex] && [self containsVertex:targetVertex]) {
        for (id e in [self getEdgeContainer:sourceVertex].vertexEdges) {
            BOOL equalStraight = [sourceVertex isEqual:[self edgeSource:e]] && [targetVertex isEqual:[self edgeTarget:e]];
            BOOL equalInverted = [sourceVertex isEqual:[self edgeTarget:e]] && [targetVertex isEqual:[self edgeSource:e]];
            
            if (equalStraight || equalInverted) {
                return e;
            }
        }
    }
    
    return nil;
}

- (void)addEdgeToTouchingVertices:(id)edge
{
    id source = [self edgeSource:edge];
    id target = [self edgeTarget:edge];
    
    [[self getEdgeContainer:source] addEdge:edge];
    
    if (![source isEqual:target]) {
        [[self getEdgeContainer:target] addEdge:edge];
    }
}

- (int)degreeOf:(id)vertex
{
    if (YES) {
        int degree = 0;
        NSArray *edges = [self getEdgeContainer:vertex].vertexEdges;
        
        for (id e in edges) {
            if ([[self edgeSource:e] isEqual: [self edgeTarget:e]]) {
                degree += 2;
            } else {
                degree++;
            }
        }
        
        return degree;
    } else {
        return [self getEdgeContainer:vertex].count;
    }
}

- (NSArray *)edgesOf:(id)vertex
{
    return [self getEdgeContainer:vertex].unmodifiableVertexEdges;
}

- (int)inDegreeOf:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:@"no such operation in an undirected graph" userInfo:nil];
}

- (NSArray *)incomingEdgesOf:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:@"no such operation in an undirected graph" userInfo:nil];
}

- (int)outgoingDegreeOf:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:@"no such operation in an undirected graph" userInfo:nil];
}

- (NSArray *)outgoingEdgesOf:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:@"no such operation in an undirected graph" userInfo:nil];
}

- (void)removeEdgeFromTouchingVertices:(id)edge
{
    id source = [self edgeSource:edge];
    id target = [self edgeTarget:edge];

    [[self getEdgeContainer:source] removeEdge:edge];

    if (![source isEqual:target]) {
        [[self getEdgeContainer:target] removeEdge:edge];
    }
}

- (CCUndirectedEdgeContainer *)getEdgeContainer:(id)vertex
{
    CCUndirectedEdgeContainer *ec = [self.vertexMapUndirected objectForKey:vertex];
    
    if ((NSNull *)ec == [NSNull null]) {
        ec = [[CCUndirectedEdgeContainer alloc] initWithFactory:[self.delegate edgeSetFactory] for:vertex];
        [self.vertexMapUndirected setObject:ec forKey:vertex];
    }
    
    return ec;
}

@end
