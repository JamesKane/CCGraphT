//
//  DefaultDirectedGraphTest.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "DefaultDirectedGraphTest.h"
#import "CCDirectedGraph.h"
#import "CCDefaultDirectedGraph.h"
#import "CCDirectedMultigraph.h"
#import "CCDefaultEdge.h"
#import "CCEdgeSetFactory.h"
#import "CCGraphs.h"

@interface DefaultDirectedGraphTest () {
    NSString *v1;
    NSString *v2;
    NSString *v3;
}
@end

@implementation DefaultDirectedGraphTest

- (void)setUp
{
    [super setUp];
    
    v1 = @"v1";
    v2 = @"v2";
    v3 = @"v3";
}

- (void)testEdgeSetFactory
{
    CCDirectedMultigraph *g = [[CCDirectedMultigraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    [g setEdgeSetFactory:[[CCArrayListFactory alloc] init]];
    [self initMultiTriangleWithMultiLoop:g];
    
    STAssertTrue([[g vertexSet] count] == 3, @"Vertex set contains %d entries", [[g vertexSet] count]);
    STAssertTrue([[g edgeSet] count] == 4, @"Edge set contains %d entries", [[g edgeSet] count]);
}

- (void)testEdgeOrderDeterminism
{
    CCDirectedMultigraph *g = [[CCDirectedMultigraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    [g addVertex:v1];
    [g addVertex:v2];
    [g addVertex:v3];
    
    CCDefaultEdge *e1 = [g createEdgeFromVertex:v1 toVertex:v2];
    CCDefaultEdge *e2 = [g createEdgeFromVertex:v2 toVertex:v2];
    CCDefaultEdge *e3 = [g createEdgeFromVertex:v3 toVertex:v1];
 
    NSEnumerator *iter = [[g edgeSet] objectEnumerator];
    CCDefaultEdge *tmp = [iter nextObject];
    STAssertEqualObjects(e1, tmp, @"edges should be equal: %@, %@", e1, tmp);
    tmp = [iter nextObject];
    STAssertEqualObjects(e2, tmp, @"edges should be equal: %@, %@", e2, tmp);
    tmp = [iter nextObject];
    STAssertEqualObjects(e3, tmp, @"edges should be equal: %@, %@", e3, tmp);
    
    STAssertTrue([CCGraphs testEdge:e1 isIncident:v1 inGraph:g], @"%@ should be in %@", e1, v1);
    STAssertTrue([CCGraphs testEdge:e1 isIncident:v2 inGraph:g], @"%@ should be in %@", e1, v2);
    STAssertFalse([CCGraphs testEdge:e1 isIncident:v3 inGraph:g], @"%@ should be in %@", e1, v3);
    STAssertEquals(v2, [CCGraphs oppositeVertex:g for:e1 from:v1], @"edges should be equal: %@, %@", v2, [CCGraphs oppositeVertex:g for:e1 from:v1]);
    STAssertEquals(v1, [CCGraphs oppositeVertex:g for:e1 from:v2], @"edges should be equal: %@, %@", v1, [CCGraphs oppositeVertex:g for:e1 from:v2]);
}

- (void)testEdgesOf
{
    CCDirectedMultigraph *g = [self createMultigraphTriangleWithMultiLoop];
    
    STAssertEquals((NSUInteger)3, [[g edgesOf:v1] count], @"%@ has %d edges", v1, [[g edgesOf:v1] count]);
    STAssertEquals((NSUInteger)2, [[g edgesOf:v2] count], @"%@ has %d edges", v2, [[g edgesOf:v2] count]);
}

- (void)testGetAllEdges
{
    CCDirectedMultigraph *g = [self createMultigraphTriangleWithMultiLoop];
    
    NSArray *loops = [g allEdgesConnecting:v1 to:v1];
    STAssertEquals((NSUInteger)1, [loops count], @"graph contains %d", [loops count]);
}

- (void)testInDegreeOf
{
    CCDirectedMultigraph *g = [self createMultigraphTriangleWithMultiLoop];
    
    STAssertEquals(2, [g inDegreeOf:v1], @"%@ has in degree of %d", v1, [g inDegreeOf:v1]);
    STAssertEquals(1, [g inDegreeOf:v2], @"%@ has in degree of %d", v2, [g inDegreeOf:v2]);
}

- (void)testOutDegreeOf
{
    CCDirectedMultigraph *g = [self createMultigraphTriangleWithMultiLoop];
    
    STAssertEquals(2, [g outgoingDegreeOf:v1], @"%@ has out degree of %d", v1, [g outgoingDegreeOf:v1]);
    STAssertEquals(1, [g outgoingDegreeOf:v2], @"%@ has out degree of %d", v2, [g outgoingDegreeOf:v2]);
}

- (void)testVertexOrderDeterminism
{
    // Disabled since NSDictionary does not ensure determinism.
    CCDirectedMultigraph *g = [self createMultigraphTriangleWithMultiLoop];
    NSEnumerator *iter = [[g vertexSet] objectEnumerator];
    STAssertEqualObjects(v1, [iter nextObject], @"objects not equal");
    STAssertEqualObjects(v2, [iter nextObject], @"objects not equal");
    STAssertEqualObjects(v3, [iter nextObject], @"objects not equal");
}

- (CCDirectedMultigraph *)createMultigraphTriangleWithMultiLoop
{
    CCDirectedMultigraph *g = [[CCDirectedMultigraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    [self initMultiTriangleWithMultiLoop:g];
    return g;
}

- (void)initMultiTriangleWithMultiLoop:(id <CCDirectedGraph, CCGraph>)g
{
    [g addVertex:v1];
    [g addVertex:v2];
    [g addVertex:v3];
    
    [g createEdgeFromVertex:v1 toVertex:v1];
    [g createEdgeFromVertex:v1 toVertex:v2];
    [g createEdgeFromVertex:v2 toVertex:v3];
    [g createEdgeFromVertex:v3 toVertex:v1];
}
@end
