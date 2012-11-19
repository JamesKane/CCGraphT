//
//  SimpleDirectedGraphTest.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "SimpleDirectedGraphTest.h"
#import "CCSimpleDirectedGraph.h"
#import "CCDefaultEdge.h"

@interface SimpleDirectedGraphTest () {
    id<CCDirectedGraph> gEmpty;
    id<CCDirectedGraph> g1;
    id<CCDirectedGraph> g2;
    id<CCDirectedGraph> g3;
    id<CCDirectedGraph> g4;
    CCDefaultEdge *eLoop;
    id<CCEdgeFactory> eFactory;
    NSString *v1;
    NSString *v2;
    NSString *v3;
    NSString *v4;
}
@end

@implementation SimpleDirectedGraphTest

- (void)setUp
{
    v1 = @"v1";
    v2 = @"v2";
    v3 = @"v3";
    v4 = @"v4";
    
    gEmpty = [[CCSimpleDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    g1 = [[CCSimpleDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    g2 = [[CCSimpleDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    g3 = [[CCSimpleDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    g4 = [[CCSimpleDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    
    eFactory = [g1 edgeFactory];
    eLoop = [eFactory createEdge:v1 to:v1];
    
    [g1 addVertex:v1];
    
    [g2 addVertex:v1];
    [g2 addVertex:v2];
    [g2 createEdgeFromVertex:v1 toVertex:v2];
    [g2 createEdgeFromVertex:v2 toVertex:v1];
    
    [g3 addVertex:v1];
    [g3 addVertex:v2];
    [g3 addVertex:v3];
    [g3 createEdgeFromVertex:v1 toVertex:v2];
    [g3 createEdgeFromVertex:v2 toVertex:v1];
    [g3 createEdgeFromVertex:v2 toVertex:v3];
    [g3 createEdgeFromVertex:v3 toVertex:v2];
    [g3 createEdgeFromVertex:v3 toVertex:v1];
    [g3 createEdgeFromVertex:v1 toVertex:v3];
    
    [g4 addVertex:v1];
    [g4 addVertex:v2];
    [g4 addVertex:v3];
    [g4 addVertex:v4];
    [g4 createEdgeFromVertex:v1 toVertex:v2];
    [g4 createEdgeFromVertex:v2 toVertex:v3];
    [g4 createEdgeFromVertex:v3 toVertex:v4];
    [g4 createEdgeFromVertex:v4 toVertex:v1];
}

- (void)testAddEdgeEdge
{
    STAssertThrows([g1 addEdge:v1 from:v1 to:eLoop], @"loops not allowed");
    STAssertThrows([g3 addEdge:v1 from:v1 to:nil], @"nil edge not allowed");
    
    CCDefaultEdge *e = [eFactory createEdge:v2 to:v1];
    STAssertThrows([g1 addEdge:@"ya" from:@"ya" to:e], @"vertex must be in graph");
    
    STAssertEquals(NO, [g2 addEdge:v2 from:v1 to:e], @"");
    STAssertEquals(NO, [g3 addEdge:v2 from:v1 to:e], @"");
    STAssertEquals(YES, [g4 addEdge:v2 from:v1 to:e], @"");
}

- (void)testAddEdgeObjectObject
{
    STAssertThrows([g1 createEdgeFromVertex:v1 toVertex:v1], @"loops not allowed");
    STAssertThrows([g3 createEdgeFromVertex:nil toVertex:nil], @"nil vertex not allowed");
    STAssertThrows([g1 createEdgeFromVertex:v2 toVertex:v1], @"vertex must be in graph");
    STAssertNil([g2 createEdgeFromVertex:v2 toVertex:v1], @"edge creation should be nil");
    STAssertNil([g3 createEdgeFromVertex:v2 toVertex:v1], @"edge create should be nil");
    STAssertNotNil([g4 createEdgeFromVertex:v2 toVertex:v1], @"edge create should not be nil");
}

- (void)testAddVertex
{
    STAssertEquals((NSUInteger)1, [[g1 vertexSet] count], @"");
    STAssertEquals((NSUInteger)2, [[g2 vertexSet] count], @"");
    STAssertEquals((NSUInteger)3, [[g3 vertexSet] count], @"");
    STAssertEquals((NSUInteger)4, [[g4 vertexSet] count], @"");
    
    STAssertFalse([g1 addVertex:v1], @"vertex in graph should not be added again");
    STAssertTrue([g1 addVertex:v2], @"vertex should be added");
    STAssertEquals((NSUInteger)2, [[g1 vertexSet] count], @"");
}

- (void)testContainsEdgeObjectObject
{
    STAssertFalse([g1 containsEdgeConnecting:v1 to:v2], @"");
    STAssertFalse([g1 containsEdgeConnecting:v1 to:v1], @"");
    
    STAssertTrue([g2 containsEdgeConnecting:v1 to:v2], @"");
    STAssertTrue([g2 containsEdgeConnecting:v2 to:v1], @"");
    
    STAssertTrue([g3 containsEdgeConnecting:v1 to:v2], @"");
    STAssertTrue([g3 containsEdgeConnecting:v2 to:v1], @"");
    STAssertTrue([g3 containsEdgeConnecting:v3 to:v2], @"");
    STAssertTrue([g3 containsEdgeConnecting:v2 to:v3], @"");
    STAssertTrue([g3 containsEdgeConnecting:v1 to:v3], @"");
    STAssertTrue([g3 containsEdgeConnecting:v3 to:v1], @"");
    
    STAssertFalse([g4 containsEdgeConnecting:v1 to:v4], @"");
    [g4 createEdgeFromVertex:v1 toVertex:v4];
    STAssertTrue([g4 containsEdgeConnecting:v1 to:v4], @"");
    
    STAssertFalse([g3 containsEdgeConnecting:v4 to:v2], @"");
    STAssertFalse([g3 containsEdgeConnecting:nil to:nil], @"");
}

- (void)testEdgesOf
{
    STAssertEquals((NSUInteger)2, [[g4 edgesOf:v1] count], @"");
    STAssertEquals((NSUInteger)4, [[g3 edgesOf:v1] count], @"");
    
    NSEnumerator *iter = [[g3 edgesOf:v1] objectEnumerator];
    
    int count = 0;
    while ([iter nextObject]) {
        count++;
    }
    
    STAssertEquals((NSUInteger)count, (NSUInteger)4, @"");
}

- (void)testInDegreeOf
{
    STAssertEquals((NSInteger)0, [g1 inDegreeOf:v1], @"");
    
    STAssertEquals((NSInteger)1, [g2 inDegreeOf:v1], @"");
    STAssertEquals((NSInteger)1, [g2 inDegreeOf:v2], @"");
    
    STAssertEquals((NSInteger)2, [g3 inDegreeOf:v1], @"");
    STAssertEquals((NSInteger)2, [g3 inDegreeOf:v2], @"");
    STAssertEquals((NSInteger)2, [g3 inDegreeOf:v3], @"");
    
    STAssertEquals((NSInteger)1, [g4 inDegreeOf:v1], @"");
    STAssertEquals((NSInteger)1, [g4 inDegreeOf:v2], @"");
    STAssertEquals((NSInteger)1, [g4 inDegreeOf:v3], @"");
    STAssertEquals((NSInteger)1, [g4 inDegreeOf:v4], @"");
    
    STAssertEquals((NSInteger)0, [g3 inDegreeOf:@""], @"");
    STAssertEquals((NSInteger)0, [g3 inDegreeOf:nil], @"");
}

- (void)testIncomingOutgoingEdgesOf
{
    NSArray *e1to2 = [g2 outgoingEdgesOf:v1];
    NSArray *e2from1 = [g2 incomingEdgesOf:v2];
    STAssertEqualObjects(e1to2, e2from1, @"");
}

- (void)testRemoveEdgeEdge
{
    STAssertEquals((NSUInteger)4, [[g4 edgeSet] count], @"");
    [g4 removeEdgeConnecting:v1 to:v2];
    STAssertEquals((NSUInteger)3, [[g4 edgeSet] count], @"");
    STAssertFalse([g4 removeEdge:eLoop], @"");
    STAssertTrue([g4 removeEdge:[g4 edgeConnecting:v2 to:v3]], @"");
    STAssertEquals((NSUInteger)2, [[g4 edgeSet] count], @"");
}

- (void)testRemoveVertex
{
    STAssertEquals((NSUInteger)4, [[g4 vertexSet] count], @"");
    STAssertTrue([g4 removeVertex:v1], @"");
    STAssertEquals((NSUInteger)3, [[g4 vertexSet] count], @"");
    
    STAssertEquals((NSUInteger)2, [[g4 edgeSet] count], @"");
    STAssertFalse([g4 removeVertex:v1], @"");
    STAssertTrue([g4 removeVertex:v2], @"");
    STAssertEquals((NSUInteger)1, [[g4 edgeSet] count], @"");
    STAssertTrue([g4 removeVertex:v3], @"");
    STAssertEquals((NSUInteger)0, [[g4 edgeSet] count], @"");
    STAssertEquals((NSUInteger)1, [[g4 vertexSet] count], @"");
    STAssertTrue([g4 removeVertex:v4], @"");
    STAssertEquals((NSUInteger)0, [[g4 vertexSet] count], @"");
}
@end
