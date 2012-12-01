//
//  CCSimpleGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractBaseGraph.h"
#import "CCUndirectedGraph.h"

@interface CCSimpleGraph : CCAbstractBaseGraph <CCUndirectedGraph>
- (id)initWithEdgeClass:(Class)edgeClass;

- (id)initWithEdgeFactory:(id <CCEdgeFactory>)ef;
@end
