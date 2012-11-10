//
//  CCGraphPathImpl.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphPathImpl.h"

@interface CCGraphPathImpl ()
@property (weak, nonatomic) id<CCGraph> graph;
@property (weak, nonatomic) id startVertex;
@property (weak, nonatomic) id endVertex;
@property (nonatomic) double weight;
@end

@implementation CCGraphPathImpl

- (id)initWith:(id<CCGraph>)graph from:(id)startVertex to:(id)endVertex having:(NSArray *)edgeList with:(double)weight
{
    if (self = [super init]) {
        self.graph = graph;
        self.startVertex = startVertex;
        self.endVertex = endVertex;
        self.weight = weight;
    }
    
    return self;
}

- (id<CCGraph>)graph
{
    return self.graph;
}

- (id)startVertex
{
    return self.startVertex;
}

- (id)endVertex
{
    return self.endVertex;
}

- (NSArray *)edgeList
{
    return self.edgeList;
}

- (double)weight
{
    return self.weight;
}

- (NSString *)description
{
    return [self.endVertex description];
}
@end
