//
//  CCGraphDelegator.h
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAbstractBaseGraph.h"

@interface CCGraphDelegator : CCAbstractBaseGraph
- (id)initWithGraph:(CCAbstractBaseGraph *)g;

- (NSInteger)inDegreeOf:(id)vertex;
@end
