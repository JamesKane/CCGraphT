//
//  CCFibonacciHeapNode.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFibonacciHeapNode : NSObject
@property (strong, nonatomic) id data;
@property (strong, nonatomic) CCFibonacciHeapNode *child;
@property (strong, nonatomic) CCFibonacciHeapNode *left;
@property (strong, nonatomic) CCFibonacciHeapNode *parent;
@property (strong, nonatomic) CCFibonacciHeapNode *right;
@property (nonatomic) BOOL mark;
@property (nonatomic) double key;
@property (nonatomic) NSUInteger degree;

- (id)initWithData:(id)data;
@end
