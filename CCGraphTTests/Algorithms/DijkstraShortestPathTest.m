//
//  DijkstraShortestPathTest.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "DijkstraShortestPathTest.h"
#import "CCDijkstraShortestPath.h"
#import "CCDefaultWeightedEdge.h"
#import "CCSimpleWeightedGraph.h"
#import "CCGraphs.h"

@interface DijkstraShortestPathTest () {
    NSString *v1;
    NSString *v2;
    NSString *v3;
    NSString *v4;
    NSString *v5;
    
    CCDefaultWeightedEdge *e12;
    CCDefaultWeightedEdge *e13;
    CCDefaultWeightedEdge *e15;
    CCDefaultWeightedEdge *e24;
    CCDefaultWeightedEdge *e34;
    CCDefaultWeightedEdge *e45;
    
    CCSimpleWeightedGraph *g;
}
@end

@implementation DijkstraShortestPathTest

- (void)setUp
{
    double bias = 1;
    
    v1 = @"v1"; v2 = @"v2"; v3 = @"v3";
    v4 = @"v4"; v5 = @"v5";
    
    g = [[CCSimpleWeightedGraph alloc] initWithEdgeClass:[CCDefaultWeightedEdge class]];
    
    [g addVertex:v1];
    [g addVertex:v2];
    [g addVertex:v3];
    [g addVertex:v4];
    [g addVertex:v5];
    
    e12 = [CCGraphs createEdgeInGraph:g from:v1 to:v2 withWeight:bias * 2];
    e13 = [CCGraphs createEdgeInGraph:g from:v1 to:v3 withWeight:bias * 3];
    e24 = [CCGraphs createEdgeInGraph:g from:v2 to:v4 withWeight:bias * 5];
    e34 = [CCGraphs createEdgeInGraph:g from:v3 to:v4 withWeight:bias * 20];
    e45 = [CCGraphs createEdgeInGraph:g from:v4 to:v5 withWeight:bias * 5];
    e15 = [CCGraphs createEdgeInGraph:g from:v1 to:v5 withWeight:bias * 100];
}

- (void)testConstructor
{
    CCDijkstraShortestPath *path = [[CCDijkstraShortestPath alloc] initWith:g withOrigin:v3 andDesitination:v4 withRadius:DBL_MAX];
    [path execute];
    NSArray *result = [NSArray arrayWithObjects:e13, e12, e24, nil];
    STAssertEqualObjects(result, [path pathEdgeList], @"paths do not match");
    STAssertEquals(10.0, [path pathLength], @"length does not match");
    
}

@end
