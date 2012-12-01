//
//  CCAsWeightedGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphDelegator.h"

@interface CCAsWeightedGraph : CCGraphDelegator

- (id)initWithGraph:(CCAbstractBaseGraph *)g andWeightMap:(NSMutableDictionary *)weightMap;

@end
