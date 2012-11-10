//
//  CCFibonacciHeap.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCFibonacciHeap.h"
#import "CCFibonacciHeapNode.h"

#define OneOverLogPhi (1.0 / log((1.0 + sqrt(5.0)) / 2.0))

@interface CCFibonacciHeap ()
@property (strong, nonatomic) CCFibonacciHeapNode *minNode;
@property (nonatomic) NSUInteger nNodes;
@end

@implementation CCFibonacciHeap
- (BOOL)isEmpty
{
    return self.minNode == nil;
}

- (void)clear
{
    self.minNode = nil;
    self.nNodes = 0;
}

- (void)decreaseNode:(CCFibonacciHeapNode *)x keyTo:(double)k
{
    if (k > x.key) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"decreaseKey got larger key value" userInfo:nil];
    }
    
    x.key = k;
    
    CCFibonacciHeapNode* y = x.parent;
    
    if ((y != nil) && (x.key < y.key)) {
        [self cut:x from:y];
        [self cascadingCut:y];
    }
    
    if (x.key < self.minNode.key) {
        self.minNode = x;
    }
}

- (void)remove:(CCFibonacciHeapNode *)x
{
    [self decreaseNode:x keyTo:DBL_MIN];
    [self removeMin];
}

- (void)insert:(CCFibonacciHeapNode *)x withKey:(double)k
{
    x.key = k;
    
    // concatenate node into min list
    if (self.minNode != nil) {
        x.left = self.minNode;
        x.right = self.minNode.right;
        self.minNode.right = x;
        x.right.left = x;
        
        if (k < self.minNode.key) {
            self.minNode = x;
        }
    } else {
        self.minNode = x;
    }
    
    self.nNodes++;
}

- (CCFibonacciHeapNode *)min
{
    return self.minNode;
}

- (CCFibonacciHeapNode *)removeMin
{
    CCFibonacciHeapNode *z = self.minNode;
    
    if (z != nil) {
        NSUInteger numKids = z.degree;
        CCFibonacciHeapNode *x = z.child;
        CCFibonacciHeapNode *tempRight;
        
        while (numKids) {
            tempRight = x.right;
            
            // remove x from child list
            x.left.right = x.right;
            x.right.left = x.left;
            
            // add x to the root list of heap
            x.left = self.minNode;
            x.right = self.minNode.right;
            self.minNode.right = x;
            x.right.left = x;
            
            // set parent[x] to nil
            x.parent = nil;
            x = tempRight;
            numKids--;
        }
        
        // remove z from root list of heap
        z.left.right = z.right;
        z.right.left = z.left;
        
        if (z == z.right) {
            self.minNode = nil;
        } else {
            self.minNode = z.right;
            [self consolidate];
        }

        self.nNodes--;
    }
    return z;
}

- (NSUInteger)size
{
    return self.nNodes;
}

+ (CCFibonacciHeap *)unionOf:(CCFibonacciHeap *)h1 with:(CCFibonacciHeap *)h2
{
    CCFibonacciHeap *result = [[CCFibonacciHeap alloc] init];
    if (h1 && h2) {
        result.minNode = h1.minNode;
        
        if (result.minNode) {
            if (h2.minNode) {
                result.minNode.right.left = h2.minNode.left;
                h2.minNode.left.right = result.minNode.right;
                result.minNode.right = h2.minNode;
                h2.minNode.left = result.minNode;
                
                if (h2.minNode.key < h1.minNode.key) {
                    result.minNode = h2.minNode;
                }
            }
        } else {
            result.minNode = h2.minNode;
        }
        
        result.nNodes = h1.nNodes + h2.nNodes;
    }
    
    return h2;
}

- (NSString *)description
{
    if (!self.minNode) {
        return @"FibonacciHeap=[]";
    }
    
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:self.nNodes];
    [stack addObject:self.minNode];
    
    NSMutableString *buf = [NSMutableString stringWithString:@"FibonacciHeap=["];
    
    while ([stack count]) {
        CCFibonacciHeapNode *curr = [stack lastObject];
        [stack removeLastObject];
        [buf appendFormat:@"%@, ", [curr description]];
        
        if (curr.child) {
            [stack addObject:curr.child];
        }
        
        CCFibonacciHeapNode *start = curr;
        curr = curr.right;
        while (curr != start) {
            [buf appendFormat:@"%@, ", [curr description]];
            if (curr.child) {
                [stack addObject:curr.child];
            }
            curr = curr.right;
        }
    }

    [buf appendString:@"]"];

    return buf;
}

- (void)cascadingCut:(CCFibonacciHeapNode *)y
{
    CCFibonacciHeapNode *z = y.parent;
    
    if (z) {
        if (!y.mark) {
            y.mark = YES;
        } else {
            [self cut:y from:z];
            [self cascadingCut:z];
        }
    }
}

- (void)consolidate
{
    NSUInteger arraySize = floor(log(self.nNodes) * OneOverLogPhi) + 1;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:arraySize];
    
    for (int i = 0; i < arraySize; i++) {
        [array insertObject:[NSValue valueWithPointer:nil] atIndex:i];   // iOS doesn't handle pointer arrays so work around using NSValue
    }
    
    int numRoots = 0;
    CCFibonacciHeapNode *x = self.minNode;
    
    if (x) {
        numRoots++;
        x = x.right;
        while(x != self.minNode) {
            numRoots++;
            x = x.right;
        }
    }
    
    while (numRoots) {
        NSUInteger d = x.degree;
        CCFibonacciHeapNode *next = x.right;
        while (YES) {
            CCFibonacciHeapNode *y = [array objectAtIndex:d];
            if (!y) {
                break;
            }
            
            if (x.key > y.key) {
                CCFibonacciHeapNode *temp = y;
                y = x;
                x = temp;
            }
            
            [self link:y to:x];
            [array replaceObjectAtIndex:d withObject:[NSValue valueWithPointer:nil]];
            d++;
        }
        [array replaceObjectAtIndex:d withObject:x];
        x = next;
        numRoots--;
    }
    
    self.minNode = nil;
    for (int i = 0; i < arraySize; i++) {
        id val = [array objectAtIndex:i];
        if (![val isKindOfClass:[CCFibonacciHeapNode class]]) {
            continue;
        }
        CCFibonacciHeapNode *y = val;
        
        if (self.minNode) {
            y.left.right = y.right;
            y.right.left = y.left;
            
            y.left = self.minNode;
            y.right = self.minNode.right;
            self.minNode.right = y;
            y.right.left = y;
            
            if (y.key < self.minNode.key) {
                self.minNode = y;
            }
        } else {
            self.minNode = y;
        }
    }
}

- (void)cut:(CCFibonacciHeapNode *)x from:(CCFibonacciHeapNode *)y
{
    x.left.right = x.right;
    x.right.left = x.left;
    y.degree--;
    
    if (y.child == x) {
        y.child = x.right;
    }
    
    if (y.degree == 0) {
        y.child = nil;
    }
    
    x.left = self.minNode;
    x.right = self.minNode.right;
    self.minNode.right = x;
    x.right.left = x;
    
    x.parent = nil;
    x.mark = NO;
}

- (void)link:(CCFibonacciHeapNode *)x to:(CCFibonacciHeapNode *)y
{
    y.left.right = y.right;
    y.right.left = y.left;
    
    y.parent = x;
    
    if (!x.child) {
        x.child = y;
        x.right = y;
        y.left = y;
    } else {
        y.left = x.child;
        y.right = x.child.right;
        x.child.right = y;
        y.right.left = y;
    }
    
    x.degree++;
    
    y.mark = false;
}
@end
