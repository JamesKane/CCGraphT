//
//  AbstractGraphIteratorTest.m
//  CCGraphT
//
//  Created by James Kane on 11/12/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "AbstractGraphIteratorTest.h"
#import "CCAbstractGraphIterator.h"
#import "CCDefaultDirectedWeightedGraph.h"
#import "CCDefaultWeightedEdge.h"
#import "CCGraphs.h"


@interface AbstractGraphIteratorTest () {
    NSMutableString *result;
}
@end

@implementation AbstractGraphIteratorTest

- (void)testDirectedGraph
{
//    result = [NSMutableArray array];
//    id<CCDirectedGraph> graph = [self createDirectedGraph];
//    
//    CCAbstractGraphIterator *iterator = [self createIterator:graph starting:@"1"];
//    
//    while ([iterator hasNext]) {
//        [result appendString:[iterator next]];
//        if ([iterator hasNext]) {
//            [result appendString:@","];
//        }
//    }
//    
//    STAssertEqualObjects([self expectedStr2], result, @"");
}

- (NSString *)expectedFinishString
{
    return @"";
}

- (CCDefaultDirectedWeightedGraph *)createDirectedGraph
{
    CCDefaultDirectedWeightedGraph *graph = [[CCDefaultDirectedWeightedGraph alloc] initWithEdgeClass:[CCDefaultWeightedEdge class]];
    
    NSString *v1 = @"1";
    NSString *v2 = @"2";
    NSString *v3 = @"3";
    NSString *v4 = @"4";
    NSString *v5 = @"5";
    NSString *v6 = @"6";
    NSString *v7 = @"7";
    NSString *v8 = @"8";
    NSString *v9 = @"9";
    
    [graph addVertex:v1];
    [graph addVertex:v2];
    [graph addVertex:v3];
    [graph addVertex:v4];
    [graph addVertex:v5];
    [graph addVertex:v6];
    [graph addVertex:v7];
    [graph addVertex:v8];
    [graph addVertex:v9];
    
    [graph addVertex:@"orphan"];
    
    [graph createEdgeFromVertex:v1 toVertex:v2];
    [CCGraphs createEdgeInGraph:graph from:v1 to:v3 withWeight:100];
    [CCGraphs createEdgeInGraph:graph from:v2 to:v4 withWeight:1000];
    [graph createEdgeFromVertex:v3 toVertex:v5];
    [CCGraphs createEdgeInGraph:graph from:v3 to:v6 withWeight:100];
    [graph createEdgeFromVertex:v5 toVertex:v6];
    [CCGraphs createEdgeInGraph:graph from:v5 to:v7 withWeight:200];
    [graph createEdgeFromVertex:v6 toVertex:v1];
    [CCGraphs createEdgeInGraph:graph from:v7 to:v8 withWeight:100];
    [graph createEdgeFromVertex:v7 toVertex:v9];
    [graph createEdgeFromVertex:v8 toVertex:v2];
    [graph createEdgeFromVertex:v9 toVertex:v4];
    
    return graph;
}

- (CCAbstractGraphIterator *)createIterator:(id<CCDirectedGraph>)g starting:(NSString *)startVertex
{
    return nil;
}
@end

@interface MyTraversalListener : NSObject

@end