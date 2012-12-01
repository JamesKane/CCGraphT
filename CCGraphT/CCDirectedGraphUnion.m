//
//  CCDirectedGraphUnion.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDirectedGraphUnion.h"

@interface CCDirectedGraphUnion ()
@property(strong, nonatomic) id <CCDirectedGraph> g1;
@property(strong, nonatomic) id <CCDirectedGraph> g2;
@end

@implementation CCDirectedGraphUnion
@synthesize g1 = _g1;
@synthesize g2 = _g2;

- (NSInteger)inDegreeOf:(id)vertex {
    NSArray *result = [self incomingEdgesOf:vertex];
    return [result count];
}

- (NSArray *)incomingEdgesOf:(id)vertex {
    NSMutableSet *result = [NSMutableSet set];
    if ([self.g1 containsVertex:vertex]) {
        [result addObjectsFromArray:[self.g1 incomingEdgesOf:vertex]];
    }
    if ([self.g2 containsVertex:vertex]) {
        [result addObjectsFromArray:[self.g2 incomingEdgesOf:vertex]];
    }
    return [NSArray arrayWithArray:[result allObjects]];
}

- (NSInteger)outgoingDegreeOf:(id)vertex {
    NSArray *result = [self outgoingEdgesOf:vertex];
    return [result count];
}

- (NSArray *)outgoingEdgesOf:(id)vertex {
    NSMutableSet *result = [NSMutableSet set];
    if ([self.g1 containsVertex:vertex]) {
        [result addObjectsFromArray:[self.g1 outgoingEdgesOf:vertex]];
    }
    if ([self.g2 containsVertex:vertex]) {
        [result addObjectsFromArray:[self.g2 outgoingEdgesOf:vertex]];
    }
    return [NSArray arrayWithArray:[result allObjects]];
}

@end
