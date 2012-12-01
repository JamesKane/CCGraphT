//
//  AsUnweightedDirectedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "AsUnweightedDirectedGraph.h"
#import "CCWeightedGraph.h"

@implementation AsUnweightedDirectedGraph

- (double)edgeWeight:(id)edge {
    return WG_DEFAULT_EDGE_WEIGHT;
}

@end
