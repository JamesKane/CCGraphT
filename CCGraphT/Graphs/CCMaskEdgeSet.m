//
//  CCMaskEdgeSet.m
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCMaskEdgeSet.h"

@interface CCMaskEdgeSet ()
@property(strong, nonatomic) NSSet *edgeSet;
@property(strong, nonatomic) id <CCGraph> graph;
@property(strong, nonatomic) id <CCMaskFunctor> mask;
@property(nonatomic) NSUInteger size;
@end

@implementation CCMaskEdgeSet

- (id)initWithGraph:(id <CCGraph>)graph usingEdges:(NSSet *)edgeSet applyingMask:(id <CCMaskFunctor>)mask {
    self = [super init];
    if (self) {
        self.graph = graph;
        self.edgeSet = edgeSet;
        self.mask = mask;
        self.size = NSUIntegerMax;
    }
    return self;
}

- (BOOL)containsObject:(id)anObject {
    return [self.edgeSet containsObject:anObject] && ![self.mask isEdgeMasked:anObject];
}

- (NSEnumerator *)objectEnumerator {
    return nil;
}

- (NSUInteger)count {
    if (_size == NSUIntegerMax) {
        _size = 0;
        NSEnumerator *iter = [self objectEnumerator];
        while ([iter nextObject]) {
            _size++;
        }
    }

    return _size;
}
@end
