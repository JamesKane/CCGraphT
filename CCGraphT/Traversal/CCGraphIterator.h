//
//  CCGraphIterator.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCTraversalListener.h"

@protocol CCGraphIterator <NSObject>
- (BOOL)isCrossComponentTraversal;

- (void)setReuseEvents:(BOOL)reuseEvents;

- (BOOL)isReuseEvents;

- (void)addTraversalListener:(id <CCTraversalListener>)l;

- (void)remove;

- (void)removeTraversalListener:(id <CCTraversalListener>)l;

- (BOOL)hasNext;

- (id)next;
@end
