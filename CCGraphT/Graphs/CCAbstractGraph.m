//
//  CCAbstractGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraph.h"

@implementation CCAbstractGraph

#pragma mark --
#pragma mark CCGraph methods
- (BOOL)containsEdge:(id)sourceVertex to:(id)targetVertex
{
    return [self getEdge:sourceVertex to:targetVertex] != nil;
}

- (BOOL)removeAllEdges:(NSArray *)edges
{
    BOOL modified = NO;
    for (id e in edges) {
        modified |= [self removeEdge:e];
    }
    return modified;
}

- (NSSet *)removeAllEdges:(id)sourceVertex to:(id)targetVertex
{
    NSSet *removed = [self allEdges:sourceVertex to:targetVertex];
    [self removeAllEdges:[removed allObjects]];
    return removed;
}

- (BOOL)removeAllVertices:(NSArray *)vertices
{
    BOOL modified = NO;
    for (id v in vertices) {
        modified |= [self removeVertex:v];
    }
    return modified;
}

#pragma mark --
#pragma mark NSObject methods
- (NSString *)description
{
    return [NSString stringWithFormat:@"Graph = {Vertices = {%@}, Edges={%@}}", [self vertexSet], [self edgeSet]];
}

- (NSUInteger)hash
{
    NSUInteger hash = [[self vertexSet] hash];
    for (id e in [self edgeSet]) {
        NSUInteger part = [e hash];
        NSUInteger source = [[self edgeSource:e] hash];
        NSUInteger target = [[self edgeTarget:e] hash];
        NSUInteger pairing = ((source + target) * (source + target +1) / 2) + target;
        part = 27 * part + pairing;
        NSUInteger weight = (NSUInteger)[self edgeWeight:e];
        part = 27 * part + (weight ^ (weight >> 32));
        hash += part;
    }
    return hash;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (object == nil || ![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    if (![[self vertexSet] isEqual:[object vertexSet]]) {
        return NO;
    }
    
    if (![[self vertexSet] count] != [[object vertexSet] count]) {
        return NO;
    }
    
    for (id e in [self edgeSet]) {
        id source = [self edgeSource:e];
        id target = [self edgeTarget:e];
        
        id<CCGraph> g = object;
        
        if (![g containsEdge:e]) {
            return NO;
        }
        
        if (![[g edgeSource:e] isEqual:source] || ![[g edgeTarget:e] isEqual:target]) {
            return NO;
        }
        
        if (ABS([self edgeWeight:e] - [self edgeWeight:e]) > 10e-7) {
            return NO;
        }
    }
    
    return YES;
}
@end
