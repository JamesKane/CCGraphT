//
//  CCGraphUnion.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphUnion.h"

static NSString *GU_READ_ONLY = @"union of graphs is read-only";

@interface CCGraphUnion ()
@property (strong, nonatomic) id<CCGraph> g1;
@property (strong, nonatomic) id<CCGraph> g2;
@property (strong, nonatomic) id<CCWeightCombiner> operator;
@end

@implementation CCGraphUnion

- (id)initWith:(id<CCGraph>)g1 and:(id<CCGraph>)g2 using:(id<CCWeightCombiner>)operator
{
    self = [super init];
    if (self) {
        self.g1 = g1;
        self.g2 = g2;
        self.operator = operator;
    }
    return self;
}

- (id)initWith:(id<CCGraph>)g1 and:(id<CCGraph>)g2
{
    return [self initWith:g1 and:g2 using:[[SumWeightCombiner alloc] init]];
}

- (NSArray *)allEdgesConnecting:(id)sourceVertex to:(id)targetVertex
{
    NSMutableSet *result = [NSMutableSet set];
    if ([self.g1 containsVertex:sourceVertex] && [self.g1 containsVertex:targetVertex]) {
        [result addObjectsFromArray:[self.g1 allEdgesConnecting:sourceVertex to:targetVertex]];
    }
    if ([self.g2 containsVertex:sourceVertex] && [self.g2 containsVertex:targetVertex]) {
        [result addObjectsFromArray:[self.g2 allEdgesConnecting:sourceVertex to:targetVertex]];
    }
    return [NSArray arrayWithArray:[result allObjects]];
}

- (id)edgeConnecting:(id)sourceVertex to:(id)targetVertex
{
    id result = nil;
    if ([self.g1 containsVertex:sourceVertex] && [self.g1 containsVertex:targetVertex]) {
        result = [self.g1 edgeConnecting:sourceVertex to:targetVertex];
    }
    if (!result && [self.g2 containsVertex:sourceVertex] && [self.g2 containsVertex:targetVertex]) {
        result = [self.g2 edgeConnecting:sourceVertex to:targetVertex];
    }
    return result;
}

- (id<CCEdgeFactory>)edgeFactory
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (BOOL)addEdge:(id)edge from:(id)sourceVertex to:(id)targetVertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (BOOL)addVertex:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (BOOL)containsEdge:(id)edge
{
    return [self.g1 containsEdge:edge] || [self.g2 containsEdge:edge];
}

- (BOOL)containsVertex:(id)vertex
{
    return [self.g1 containsVertex:vertex] || [self.g2 containsVertex:vertex];
}

- (NSArray *)edgeSet
{
    NSMutableSet *result = [NSMutableSet setWithArray:[self.g1 edgeSet]];
    [result addObjectsFromArray:[self.g2 edgeSet]];
    return [NSArray arrayWithArray:[result allObjects]];
}

- (NSArray *)edgesOf:(id)vertex
{
    NSMutableSet *result = [NSMutableSet set];
    if ([self.g1 containsVertex:vertex]) {
        [result addObjectsFromArray:[self.g1 edgesOf:vertex]];
    }
    if ([self.g2 containsVertex:vertex]) {
        [result addObjectsFromArray:[self.g2 edgesOf:vertex]];
    }
    return [NSArray arrayWithArray:[result allObjects]];
}

- (id)removeEdgeConnecting:(id)sourceVertex to:(id)targetVertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (BOOL)removeEdge:(id)edge
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (BOOL)removeVertex:(id)vertex
{
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:GU_READ_ONLY userInfo:nil];
}

- (NSArray *)vertexSet
{
    NSMutableSet *result = [NSMutableSet setWithArray:[self.g1 vertexSet]];
    [result addObjectsFromArray:[self.g2 vertexSet]];
    return [NSArray arrayWithArray:[result allObjects]];
}

- (id)edgeSource:(id)edge
{
    if ([self.g1 containsEdge:edge]) {
        return [self.g1 edgeSource:edge];
    }
    if ([self.g2 containsEdge:edge]) {
        return [self.g2 edgeSource:edge];
    }
    return nil;
}

- (id)edgeTarget:(id)edge
{
    if ([self.g1 containsEdge:edge]) {
        return [self.g1 edgeTarget:edge];
    }
    if ([self.g2 containsEdge:edge]) {
        return [self.g2 edgeTarget:edge];
    }
    return nil;
}

- (double)edgeWeight:(id)edge
{
    if ([self.g1 containsEdge:edge] && [self.g2 containsEdge:edge]) {
        return [self.operator combine:[self.g1 edgeWeight:edge] with:[self.g2 edgeWeight:edge]];
    }
    if ([self.g1 containsEdge:edge]) {
        return [self.g1 edgeWeight:edge];
    }
    if ([self.g2 containsEdge:edge]) {
        return [self.g2 edgeWeight:edge];
    }
    @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"no such edge in the union" userInfo:nil];
}

- (id<CCGraph>)g1
{
    return _g1;
}

- (id<CCGraph>)g2
{
    return _g2;
}
@end
