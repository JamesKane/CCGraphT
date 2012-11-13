//
//  CCFibonacciHeap.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCFibonacciHeap.h"
#import "CCFibonacciHeapNode.h"

@interface CCFibonacciHeap ()
@property (strong, nonatomic) CCFibonacciHeapNode *minNode;
@property (nonatomic) NSUInteger nNodes;
@end

@implementation CCFibonacciHeap
@synthesize minNode = _minNode;
@synthesize nNodes = _nNodes;

- (BOOL)isEmpty
{
    return _minNode == nil;
}

- (void)clear
{
    _minNode = nil;
    _nNodes = 0;
}

- (void)decreaseNode:(CCFibonacciHeapNode *)x keyTo:(double)k
{
    if (k > x.key) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"decreaseNode:keyTo: got larger key value" userInfo:nil];
    }
    
    x.key = k;
    
    CCFibonacciHeapNode* y = x.parent;
    if ((y != nil) && (x.key < y.key)) {
        [self cut:x from:y];
        [self cascadingCut:y];
    }
    
    if (x.key < _minNode.key) {
        _minNode = x;
    }
}

- (void)remove:(CCFibonacciHeapNode *)x
{
    [self decreaseNode:x keyTo:DBL_MIN];
    [self removeMin];
}

- (void)insert:(CCFibonacciHeapNode *)node withKey:(double)key
{
    node.key = key;
    
    if (_minNode != nil) {
        [self addNode:node toHeap:_minNode];
        if (key < _minNode.key) {
            _minNode = node;
        }
    } else {
        _minNode = node;
    }
    
    _nNodes++;
}

- (CCFibonacciHeapNode *)min
{
    return _minNode;
}

- (CCFibonacciHeapNode *)removeMin
{
    CCFibonacciHeapNode *z = _minNode;
    
    if (z != nil) {
        NSUInteger numKids = z.degree;
        CCFibonacciHeapNode *x = z.child;
        CCFibonacciHeapNode *tempRight;
        
        while (numKids) {
            tempRight = x.right;
            [self unlinkNode:x];
            [self addNode:x toHeap:_minNode];
            x.parent = nil;
            x = tempRight;
            numKids--;
        }
        
        [self unlinkNode:z];
        if (z == z.right) {
            _minNode = nil;
        } else {
            _minNode = z.right;
            [self consolidate];
        }

        self.nNodes--;
    }
    return z;
}

- (NSUInteger)size
{
    return _nNodes;
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
    if (!_minNode) {
        return @"FibonacciHeap=[]";
    }
    
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:_nNodes];
    [stack addObject:_minNode];
    
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

- (void)addNode:(CCFibonacciHeapNode *)node toHeap:(CCFibonacciHeapNode *)heap
{
    node.left = heap;               
    node.right = heap.right;       
    heap.right = node;           
    node.right.left = node;       
}

- (void)unlinkNode:(CCFibonacciHeapNode *)node
{
    node.left.right = node.right;
    node.right.left = node.left;
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

#define OneOverLogPhi (1.0 / log((1.0 + sqrt(5.0)) / 2.0))
- (void)consolidate
{
    NSUInteger arraySize = floor(log(_nNodes) * OneOverLogPhi) + 1;
    NSMutableArray *array = [self createPointerArrayWith:arraySize];
    
    for (int i = 0; i < arraySize; i++) {
        [array insertObject:[NSNull null] atIndex:i];   // iOS doesn't handle pointer arrays so work around using NSNull
    }
    
    [self buildTrees:_minNode usingPointerArray:array withSize:arraySize];
    
    _minNode = nil;
    
    [self rebuildHeapTreesFromArray:array withSize:arraySize];
}

- (NSMutableArray *)createPointerArrayWith:(NSUInteger)arraySize
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:arraySize];
    
    for (int i = 0; i < arraySize; i++) {
        [array insertObject:[NSNull null] atIndex:i];   // iOS doesn't handle pointer arrays so work around using NSNull
    }
    return array;
}

- (void)buildTrees:(CCFibonacciHeapNode *)heap usingPointerArray:(NSMutableArray *)array withSize:(NSUInteger)size
{
    CCFibonacciHeapNode *x = _minNode;
    int numRoots = [self countRoots:x];
    
    while (numRoots > 0) {
        NSUInteger d = x.degree;
        CCFibonacciHeapNode *next = x.right;
        while (YES) {
            CCFibonacciHeapNode *y = [array objectAtIndex:d];
            if ([(NSNull *)y isEqual:[NSNull null]]) {
                break;
            }
            
            if (x.key > y.key) {
                CCFibonacciHeapNode *temp = y;
                y = x;
                x = temp;
            }
            
            [self link:y to:x];
            [array replaceObjectAtIndex:d withObject:[NSNull null]];
            d++;
        }
        [array replaceObjectAtIndex:d withObject:x];
        x = next;
        numRoots--;
    }
}

- (NSUInteger)countRoots:(CCFibonacciHeapNode *)heap
{
    NSUInteger numRoots = 0;
    if (heap != nil) {
        numRoots++;
        heap = heap.right;
        while(heap != _minNode) {
            numRoots++;
            heap = heap.right;
        }
    }
    return numRoots;
}

- (void)rebuildHeapTreesFromArray:(NSMutableArray *)array withSize:(NSUInteger)arraySize
{
    for (int i = 0; i < arraySize; i++) {
        id val = [array objectAtIndex:i];
        if ([val isEqual:[NSNull null]]) {
            continue;
        }
        CCFibonacciHeapNode *y = val;
        
        if (_minNode) {
            [self unlinkNode:y];
            [self addNode:y toHeap:_minNode];
            if (y.key < _minNode.key) {
                _minNode = y;
            }
        } else {
            _minNode = y;
        }
    }
}

- (void)cut:(CCFibonacciHeapNode *)x from:(CCFibonacciHeapNode *)y
{
    [self unlinkNode:x];
    y.degree--;
    
    if (y.child == x) {
        y.child = x.right;
    }
    
    if (y.degree == 0) {
        y.child = nil;
    }
    
    [self addNode:x toHeap:_minNode];
       
    x.parent = nil;
    x.mark = NO;
}

- (void)link:(CCFibonacciHeapNode *)y to:(CCFibonacciHeapNode *)x
{
    [self unlinkNode:y];
    
    y.parent = x;
    
    if (!x.child) {
        x.child = y;
        y.right = y;
        y.left = y;
    } else {
        y.left = x.child;
        y.right = x.child.right;
        x.child.right = y;
        y.right.left = y;
    }
    
    x.degree++;
    
    y.mark = NO;
}
@end
