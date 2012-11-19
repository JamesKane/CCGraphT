//
//  DepthFirstIteratorTest.m
//  CCGraphT
//
//  Created by James Kane on 11/14/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "DepthFirstIteratorTest.h"
#import "CCDepthFirstIterator.h"
#import "CCDirectedGraph.h"
#import "CCDefaultDirectedGraph.h"
#import "CCDefaultEdge.h"

@implementation DepthFirstIteratorTest

- (NSString *)expectedString1
{
    return @"1,3,6,5,7,9,4,8,2";
}

- (NSString *)expectedString2
{
    return @"1,3,6,5,7,9,4,8,2,orphan";
}

- (NSString *)expectedFinishString
{
    return @"6:4:9:2:8:7:5:3:1:orphan";
}

- (CCAbstractGraphIterator*)createIterator:(CCAbstractGraph *) g from:(id)vertex
{
    CCAbstractGraphIterator *i = [[CCDepthFirstIterator alloc] initWithGraph:g startFrom:vertex];
    i.crossComponentTraversal = YES;
    return i;
}

- (void)testBug1169182
{
    CCDefaultDirectedGraph *dg = [[CCDefaultDirectedGraph alloc] initWithEdgeClass:[CCDefaultEdge class]];
    
    NSString *a = @"A";
    NSString *b = @"B";
    NSString *c = @"C";
    NSString *d = @"D";
    NSString *e = @"E";
    NSString *f = @"F";
    NSString *g = @"G";
    NSString *h = @"H";
    NSString *i = @"I";
    NSString *j = @"J";
    NSString *k = @"K";
    NSString *l = @"L";
    
    [dg addVertex:a];
    [dg addVertex:b];
    [dg addVertex:c];
    [dg addVertex:d];
    [dg addVertex:e];
    [dg addVertex:f];
    [dg addVertex:g];
    [dg addVertex:h];
    [dg addVertex:i];
    [dg addVertex:j];
    [dg addVertex:k];
    [dg addVertex:l];
    
    [dg createEdgeFromVertex:a toVertex:b];
    [dg createEdgeFromVertex:b toVertex:c];
    [dg createEdgeFromVertex:c toVertex:j];
    [dg createEdgeFromVertex:c toVertex:d];
    [dg createEdgeFromVertex:c toVertex:e];
    [dg createEdgeFromVertex:c toVertex:f];
    [dg createEdgeFromVertex:c toVertex:g];
    [dg createEdgeFromVertex:d toVertex:h];
    [dg createEdgeFromVertex:e toVertex:h];
    [dg createEdgeFromVertex:f toVertex:i];
    [dg createEdgeFromVertex:g toVertex:i];
    [dg createEdgeFromVertex:h toVertex:j];
    [dg createEdgeFromVertex:i toVertex:c];
    [dg createEdgeFromVertex:j toVertex:k];
    [dg createEdgeFromVertex:k toVertex:l];
    
    CCDepthFirstIterator *dfs = [[CCDepthFirstIterator alloc] initWithGraph:dg];
    NSMutableString *actual = [NSMutableString string];
    while ([dfs hasNext]) {
        [actual appendString:[dfs next]];
    }
    
    NSString *expected = @"ABCGIFEHJKLD";
    STAssertEqualObjects(actual, expected, @"Search did not work as expected");
}
@end
