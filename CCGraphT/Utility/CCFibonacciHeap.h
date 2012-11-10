//
//  CCFibonacciHeap.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCFibonacciHeapNode;

@interface CCFibonacciHeap : NSObject

- (BOOL)isEmpty;
- (void)clear;
- (void)decreaseNode:(CCFibonacciHeapNode *)x keyTo:(double)k;
- (void)remove:(CCFibonacciHeapNode *)x;
- (void)insert:(CCFibonacciHeapNode *)x withKey:(double)k;
- (NSUInteger)size;
- (CCFibonacciHeapNode *)min;

+ (CCFibonacciHeap *)unionOf:(CCFibonacciHeap *)h1 with:(CCFibonacciHeap *)h2;

- (CCFibonacciHeapNode *)removeMin;

- (void)cut:(CCFibonacciHeapNode *)x from:(CCFibonacciHeapNode *)y;
- (void)cascadingCut:(CCFibonacciHeapNode *)x;
- (void)consolidate;
- (void)link:(CCFibonacciHeapNode *)x to:(CCFibonacciHeapNode *)y;
@end
