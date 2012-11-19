//
//  BreadthFirstIteratorTest.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "BreadthFirstIteratorTest.h"
#import "CCBreadthFirstIterator.h"

@interface BreadthFirstIteratorTest ()
@property (strong, nonatomic) NSMutableString *result;
@end


@implementation BreadthFirstIteratorTest

- (NSString* )expectedStr1
{
    return @"1,2,3,4,5,6,7,8,9";
}

- (NSString *)expectedStr2
{
    return @"1,2,3,4,5,6,7,8,9,orphan";
}

- (CCAbstractGraphIterator *)createIterator:(id<CCDirectedGraph>)g starting:(NSString *)startVertex
{
    CCAbstractGraphIterator *i = [[CCBreadthFirstIterator alloc] initWithGraph:g startFrom:startVertex];
    i.crossComponentTraversal = YES;
    return i;
}

- (void)testDirectedGraph
{
    self.result = [NSMutableString string];
    id<CCDirectedGraph> graph = [self createDirectedGraph];
    
    CCAbstractGraphIterator *iterator = [self createIterator:graph starting:@"1"];
    
    while ([iterator hasNext]) {
        [self.result appendString:[iterator next]];
        if ([iterator hasNext]) {
            [self.result appendString:@","];
        }
    }
    
    STAssertEqualObjects([self expectedStr2], self.result, @"");
}

@end
