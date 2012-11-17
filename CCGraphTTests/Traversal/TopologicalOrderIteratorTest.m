//
//  TopologicalOrderIteratorTest.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "TopologicalOrderIteratorTest.h"
#import "CCTopologicalOrderIterator.h"
#import "CCDefaultDirectedGraph.h"
#import "CCDefaultEdge.h"
#import "CCEdgeReversedGraph.h"

@implementation TopologicalOrderIteratorTest

#define ADD_VERTEX(index) [graph addVertex:[v objectAtIndex:(index)]]
#define ADD_EDGE(i1, i2) [graph createEdgeFromVertex:[v objectAtIndex:(i1)] toVertex:[v objectAtIndex:(i2)]]

- (void)testRecipe
{
    CCAbstractBaseGraph *graph = [[CCDefaultDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    NSArray *v = [NSArray arrayWithObjects:@"preheat oven",
                  @"sift dry ingredients", @"stir wet ingredients",
                  @"mix wet and dry ingredients", @"spoon onto pan",
                  @"bake", @"cool", @"frost", @"eat", nil];
    
    ADD_VERTEX(4);
    ADD_VERTEX(8);
    ADD_VERTEX(1);
    ADD_VERTEX(3);
    ADD_VERTEX(7);
    ADD_VERTEX(6);
    ADD_VERTEX(0);
    ADD_VERTEX(2);
    ADD_VERTEX(5);
    
    ADD_EDGE(0, 1);
    ADD_EDGE(1, 2);
    ADD_EDGE(0, 2);
    ADD_EDGE(1, 3);
    ADD_EDGE(2, 3);
    ADD_EDGE(3, 4);
    ADD_EDGE(4, 5);
    ADD_EDGE(5, 6);
    ADD_EDGE(6, 7);
    ADD_EDGE(7, 8);
    ADD_EDGE(6, 8);
    
    id<CCGraphIterator> iter = [[CCTopologicalOrderIterator alloc] initWithGraph:graph];
    int i = 0;
    
    while ([iter hasNext]) {
        STAssertEqualObjects([v objectAtIndex:i], [iter next], @"");
        ++i;
    }
    
    // Reversed graph
    CCEdgeReversedGraph *reversed = [[CCEdgeReversedGraph alloc] initWithGraph:graph];
    iter = [[CCTopologicalOrderIterator alloc] initWithGraph:reversed];
    i = [v count] - 1;
    
    while ([iter hasNext]) {
        STAssertEqualObjects([v objectAtIndex:i], [iter next], @"");
        --i;
    }
}

- (void)testEmptyGraph
{
    id<CCDirectedGraph> graph = [[CCDefaultDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    id<CCGraphIterator> iter = [[CCTopologicalOrderIterator alloc] initWithGraph:graph];
    STAssertFalse([iter hasNext], @"");
}

@end
