//
//  CCWeightedGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraph.h"

#define WG_DEFAULT_EDGE_WEIGHT 1;

@protocol CCWeightedGraph <CCGraph>
- (void)setEdge:(id)e withWeight:(double)weight;
@end
