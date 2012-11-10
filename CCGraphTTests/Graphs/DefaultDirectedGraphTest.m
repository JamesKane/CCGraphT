//
//  DefaultDirectedGraphTest.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "DefaultDirectedGraphTest.h"
#import "CCDefaultDirectedGraph.h"
#import "CCDefaultEdge.h"
#import "CCEdgeSetFactory.h"

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
    CCDefaultDirectedGraph *g = [[CCDefaultDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    [g setEdgeSetFactory:[[CCArrayListFactory alloc] init]];
    [self initMultiTriangleWithMultiLoop:g];
    
    STAssertTrue([[g vertexSet] count] == 3, @"Vertex set contains %d entries", [[g vertexSet] count]);
    STAssertTrue([[g edgeSet] count] == 4, @"Edge set contains %d entries", [[g edgeSet] count]);
    
    NSLog(@"%@", g);
}

- (void)initMultiTriangleWithMultiLoop:(CCDefaultDirectedGraph *)g
{
    [g addVertex:v1];
    [g addVertex:v2];
    [g addVertex:v3];
    
    [g addEdge:v1 to:v1];
    [g addEdge:v1 to:v2];
    [g addEdge:v2 to:v3];
    [g addEdge:v3 to:v1];
}
@end
