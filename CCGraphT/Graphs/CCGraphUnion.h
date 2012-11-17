//
//  CCGraphUnion.h
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractGraph.h"
#import "CCWeightCombiner.h"

@interface CCGraphUnion : CCAbstractGraph

- (id)initWith:(id<CCGraph>)g1 and:(id<CCGraph>)g2 using:(id<CCWeightCombiner>)operator;
- (id)initWith:(id<CCGraph>)g1 and:(id<CCGraph>)g2;

- (id<CCGraph>)g1;
- (id<CCGraph>)g2;
@end
