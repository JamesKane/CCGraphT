//
//  CCDefaultWeightedEdge.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDefaultWeightedEdge.h"
#import "CCWeightedGraph.h"

@implementation CCDefaultWeightedEdge

- (id)init {
    if (self = [super init]) {
        self.weight = WG_DEFAULT_EDGE_WEIGHT;
    }
    return self;
}

@end
