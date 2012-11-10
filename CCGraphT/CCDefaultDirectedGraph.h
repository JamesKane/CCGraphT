//
//  CCDefaultDirectedGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractBaseGraph.h"
#import "CCDirectedGraph.h"

@class CCClassBasedEdgeFactory;

@interface CCDefaultDirectedGraph : CCAbstractBaseGraph <CCDirectedGraph>
- (id)initWithEdgeClass:(Class)edgeClass;
- (id)initWithEdgeFactory:(id <CCEdgeFactory>)ef;
@end
