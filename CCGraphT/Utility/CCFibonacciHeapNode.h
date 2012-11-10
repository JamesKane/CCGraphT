//
//  CCFibonacciHeapNode.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFibonacciHeapNode : NSObject
@property (weak, nonatomic) id data;
@property (weak, nonatomic) CCFibonacciHeapNode *child;
@property (weak, nonatomic) CCFibonacciHeapNode *left;
@property (weak, nonatomic) CCFibonacciHeapNode *parent;
@property (weak, nonatomic) CCFibonacciHeapNode *right;
@property (nonatomic) BOOL mark;
@property (nonatomic) double key;
@property (nonatomic) NSUInteger degree;

- (id)initWithData:(id)data;
@end
