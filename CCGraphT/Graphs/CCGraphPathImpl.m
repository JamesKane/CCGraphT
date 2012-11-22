//
//  CCGraphPathImpl.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphPathImpl.h"

@interface CCGraphPathImpl ()
@property (strong, nonatomic) id<CCGraph> graph;
@property (strong, nonatomic) NSArray *edgeList;
@property (strong, nonatomic) id startVertex;
@property (strong, nonatomic) id endVertex;
@property (nonatomic) double weight;
@end

@implementation CCGraphPathImpl
@synthesize graph = _graph;
@synthesize edgeList = _edgeList;
@synthesize startVertex = _startVertex;
@synthesize endVertex = _endVertex;
@synthesize weight = _weight;

- (id)initWith:(id<CCGraph>)graph from:(id)startVertex to:(id)endVertex having:(NSArray *)edgeList with:(double)weight
{
    if (self = [super init]) {
        self.graph = graph;
        self.edgeList = edgeList;
        self.startVertex = startVertex;
        self.endVertex = endVertex;
        self.weight = weight;
    }
    
    return self;
}

- (id<CCGraph>)graph
{
    return _graph;
}

- (id)startVertex
{
    return _startVertex;
}

- (id)endVertex
{
    return _endVertex;
}

- (NSArray *)edgeList
{
    return _edgeList;
}

- (double)weight
{
    return _weight;
}

- (NSString *)description
{
    return [self.endVertex description];
}
@end
