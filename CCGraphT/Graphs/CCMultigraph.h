//
//  CCMultigraph.h
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractBaseGraph.h"

@interface CCMultigraph : CCAbstractBaseGraph
- (id)initWithEdgeClass:(Class)edgeClass;

- (id)initWithEdgeFactory:(id <CCEdgeFactory>)ef;
@end
