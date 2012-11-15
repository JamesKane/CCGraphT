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
@end
