//
//  CCMaskSubgraph.h
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraph.h"
#import "CCMaskFunctor.h"

@interface CCMaskSubgraph : CCAbstractGraph

- (id)initWithGraph:(id<CCGraph>)base andMask:(id<CCMaskFunctor>)mask;

@end
