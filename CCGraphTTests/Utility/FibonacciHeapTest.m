//
//  FibonacciHeapTest.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "FibonacciHeapTest.h"
#import "CCFibonacciHeap.h"
#import "CCFibonacciHeapNode.h"

@implementation FibonacciHeapTest

- (void)testAddRemoveOne
{
    NSString *s = @"A";
    CCFibonacciHeapNode *n = [[CCFibonacciHeapNode alloc] initWithData:s];
    CCFibonacciHeap *h = [[CCFibonacciHeap alloc] init];
    
    STAssertTrue([h isEmpty], @"new heap should be empty");
    
    [h insert:n withKey:1.0];
    STAssertFalse([h isEmpty], @"heap should not be empty");
    
    CCFibonacciHeapNode *n2 = [h removeMin];
    STAssertEqualObjects(s, n2.data, @"node payload doesn't match what was put in");
    STAssertTrue([h isEmpty], @"heap should be empty");
}

- (void)testAddAndRemove
{
    CCFibonacciHeap *h = [[CCFibonacciHeap alloc] init];
    CCFibonacciHeapNode *n1 = [[CCFibonacciHeapNode alloc] initWithData:@"A"];
    CCFibonacciHeapNode *n2 = [[CCFibonacciHeapNode alloc] initWithData:@"B"];
    CCFibonacciHeapNode *n3 = [[CCFibonacciHeapNode alloc] initWithData:@"C"];
    CCFibonacciHeapNode *n4 = [[CCFibonacciHeapNode alloc] initWithData:@"D"];
    
    [h insert:n1 withKey:6807.0];
    [h insert:n2 withKey:5249.0];
    STAssertEqualObjects(n2, [h min], @"should be the heap min");
    STAssertEqualObjects(n1, n2.left, @"heap min left should be n1");
    STAssertEqualObjects(n1, n2.right, @"heap min right should be n1");
    STAssertEqualObjects(n2, n1.left, @"n1 left should be heap min");
    STAssertEqualObjects(n2, n1.right, @"n1 right should be heap min");
    
    [h insert:n3 withKey:73.0];
    STAssertEqualObjects(n3, [h min], @"n3 should be the heap min");
    STAssertEqualObjects(n1.left, n3, @"");
    STAssertEqualObjects(n1.right, n2, @"");
    STAssertEqualObjects(n2.left, n1, @"");
    STAssertEqualObjects(n2.right, n3, @"");
    STAssertEqualObjects(n3.left, n2, @"");
    STAssertEqualObjects(n3.right, n1, @"");
    
    [h insert:n4 withKey:3658.0];
    STAssertEqualObjects(n1.left, n4, @"");
    STAssertEqualObjects(n1.right, n2, @"");
    
    STAssertEqualObjects(n2.left, n1, @"");
    STAssertEqualObjects(n2.right, n3, @"");
    
    STAssertEqualObjects(n3.left, n2, @"");
    STAssertEqualObjects(n3.right, n4, @"");
    
    STAssertEqualObjects(n4.left, n3, @"");
    STAssertEqualObjects(n4.right, n1, @"");
    
    [h removeMin];
    STAssertEqualObjects(n1.left, n1, @"");
    STAssertEqualObjects(n1.right, n1, @"");
    STAssertEqualObjects(n1.parent, n4, @"");
    
    STAssertEqualObjects(n2.left, n4, @"");
    STAssertEqualObjects(n2.right, n4, @"");
    
    STAssertEqualObjects(n4.left, n2, @"");
    STAssertEqualObjects(n4.right, n2, @"");
    STAssertEqualObjects(n4.child, n1, @"");
}

- (void)testGrowReplaceShrink
{
    int k = 10000;
    NSString *s = @"A";
    double t = 0;
    CCFibonacciHeap *h = [[CCFibonacciHeap alloc] init];
    for (int i = 0; i < (k * 3); ++i) {
        if (i < (k * 2)) {
            double d = rand() % 10000;
            t += d;
            CCFibonacciHeapNode *n = [[CCFibonacciHeapNode alloc] initWithData:s];
            [h insert:n withKey:d];
        }
        
        if (i >= k) {
            CCFibonacciHeapNode *n2 = [h removeMin];
            t -= n2.key;
        }
    }
    STAssertTrue([h isEmpty], @"heap should have been exhausted");
    STAssertEqualsWithAccuracy(0.0, t, 0.00001, @"tally should be zero(ish)");
}
@end
