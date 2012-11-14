//
//  CCDepthFirstIterator.h
//  CCGraphT
//
//  Created by James Kane on 11/13/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCCrossComponentIterator.h"

@interface CCDepthFirstIterator : CCCrossComponentIterator

- (id)initWithGraph:(CCAbstractBaseGraph *)graph;

@end
