//
//  CCDijkstraShortestPath.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDijkstraShortestPath.h"
#import "CCGraphPathImpl.h"
#import "CCClosestFirstIterator.h"
#import "CCGraphs.h"

@interface CCDijkstraShortestPath ()
@property (strong, nonatomic) id<CCGraph> graph;
@property (strong, nonatomic) id startVertex;
@property (strong, nonatomic) id endVertex;
@property (nonatomic) double radius;
@property (strong, nonatomic) CCGraphPathImpl *path;
@end

@implementation CCDijkstraShortestPath
@synthesize path = _path;

+ (NSArray *)findPathBetween:(id<CCGraph>)graph withOrigin:(id)startVertex andDesitination:(id)endVertex
{
    CCDijkstraShortestPath *alg = [[CCDijkstraShortestPath alloc] initWith:graph withOrigin:startVertex andDesitination:endVertex];
    [alg execute];
    return alg.pathEdgeList;
}

- (id)initWith:(id<CCGraph>)graph withOrigin:(id)startVertex andDesitination:(id)endVertex
{
    return [self initWith:graph withOrigin:startVertex andDesitination:endVertex withRadius:DBL_MAX];
}

- (id)initWith:(id<CCGraph>)graph withOrigin:(id)startVertex andDesitination:(id)endVertex withRadius:(double)radius
{
    if (![graph containsVertex:endVertex]) {
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"graph must contain the end vertex" userInfo:nil];
    }
    
    if (self = [super init]) {
        self.graph = graph;
        self.startVertex = startVertex;
        self.endVertex = endVertex;
        self.radius = radius;
    }
    return self;
}

- (void)execute
{
    CCClosestFirstIterator *iter = [[CCClosestFirstIterator alloc] initWithGraph:self.graph startFrom:self.startVertex withRadius:self.radius];
    while ([iter hasNext]) {
        id vertex = [iter next];
        
        if ([vertex isEqual:self.endVertex]) {
            [self createEdgeList:self.graph using:iter from:self.startVertex to:self.endVertex];
            return;
        }
    }
    
    self.path = nil;
}

- (NSArray *)pathEdgeList
{
    return [self.path edgeList];
}

- (id<CCGraphPath>)path
{
    return _path;
}

- (double)pathLength
{
    return self.path == nil ? DBL_MAX : self.path.weight;
}

- (void)createEdgeList:(id <CCGraph>)graph using:(CCClosestFirstIterator *)iter from:(id)startVertex to:(id)endVertex
{
    NSMutableArray *edgeList = [NSMutableArray array];
    
    id v = endVertex;
    
    while (YES) {
        id edge = [iter spanningTreeEdge:v];
        
        if (!edge) {
            break;
        }
        
        [edgeList addObject:edge];
        v = [CCGraphs oppositeVertex:graph for:edge from:v];
    }
    
    double pathLength = [iter shortestPathLength:endVertex];
    self.path = [[CCGraphPathImpl alloc] initWith:graph
                                             from:startVertex
                                               to:endVertex
                                           having:[[edgeList reverseObjectEnumerator] allObjects]
                                             with:pathLength];
}
@end
