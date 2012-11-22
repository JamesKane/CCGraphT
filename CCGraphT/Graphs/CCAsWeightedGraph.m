//
//  CCAsWeightedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAsWeightedGraph.h"
#import "CCWeightedGraph.h"

@interface CCAsWeightedGraph ()
@property (strong, nonatomic) NSMutableDictionary *weightMap;
@property (nonatomic) BOOL isWeightedGraph;
@end

@implementation CCAsWeightedGraph
@synthesize weightMap = _weightMap;
@synthesize isWeightedGraph = _isWeightedGraph;

- (id)initWithGraph:(CCAbstractBaseGraph *)g andWeightMap:(NSMutableDictionary *)weightMap
{
    self = [super initWithGraph:g];
    if (self) {
        self.weightMap = weightMap;
        self.isWeightedGraph = [g conformsToProtocol:@protocol(CCWeightedGraph)];
    }
    
    return self;
}

- (void)setEdge:(id)edge withWeight:(double)weight
{
    if (self.isWeightedGraph) {
        [super setEdge:edge withWeight:weight];
    }
    
    [self.weightMap setObject:[NSNumber numberWithDouble:weight] forKey:edge];
}

- (double)edgeWeight:(id)edge
{
    NSNumber *w = [self.weightMap objectForKey:edge];
    return w != nil ? [w doubleValue] : [super edgeWeight:edge];
}

@end
