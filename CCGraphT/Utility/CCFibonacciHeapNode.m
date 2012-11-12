//
//  CCFibonacciHeapNode.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCFibonacciHeapNode.h"

@implementation CCFibonacciHeapNode

- (id)initWithData:(id)data
{
    if (self = [super init]) {
        self.data = data;
        self.right = self;
        self.left = self;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"Freeing %@ with key: %f", self.data, self.key);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%f", self.key];
}

@end
