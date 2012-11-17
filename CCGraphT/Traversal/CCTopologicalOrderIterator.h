//
//  CCTopologicalOrderIterator.h
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCCrossComponentIterator.h"

@interface CCTopologicalOrderIterator : CCCrossComponentIterator

- (id)initWithGraph:(CCAbstractGraph *)graph;

@end
