//
//  CCTopologicalOrderIterator.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCTopologicalOrderIterator.h"
#import "CCDirectedGraph.h"

@interface CCTopologicalOrderIterator ()
@property(strong, nonatomic) NSMutableArray *queue;
@property(strong, nonatomic) NSMutableDictionary *inDegreeMap;
@end

@implementation CCTopologicalOrderIterator

- (id)initWithGraph:(id <CCDirectedGraph>)graph {
    return [self initWithGraph:graph usingQueue:[NSMutableArray array]];
}

- (id)initWithGraph:(id <CCDirectedGraph>)graph usingQueue:(NSMutableArray *)queue {
    return [self initWithGraph:graph usingQueue:queue andMap:[NSMutableDictionary dictionary]];
}

- (id)initWithGraph:(id <CCDirectedGraph>)graph usingQueue:(NSMutableArray *)queue andMap:(NSMutableDictionary *)map {
    self = [self initWithGraph:graph startFrom:[self initialize:graph usingQueue:queue andMap:map]];
    if (self) {
        self.queue = queue;
        self.inDegreeMap = map;
    }

    return self;
}

- (BOOL)isConnectedComponentExhausted {
    return [self.queue count] == 0;
}

- (void)encounterVertex:(id)vertex with:(id)edge {
    [self putSeenData:[NSNull null] withKey:vertex];
    [self decrementInDegree:vertex];
}

- (void)encounterVertexAgain:(id)vertex with:(id)edge {
    [self decrementInDegree:vertex];
}

- (id)provideNextVertex {
    id v = [self.queue lastObject];
    [self.queue removeLastObject];
    return v;
}

- (void)decrementInDegree:(id)vertex {
    NSNumber *inDegree = (self.inDegreeMap)[vertex];

    if ([inDegree integerValue] > 0) {
        inDegree = @([inDegree integerValue] - 1);
        (self.inDegreeMap)[vertex] = inDegree;

        if ([inDegree integerValue] == 0) {
            [self.queue addObject:vertex];
        }
    }
}

- (id)initialize:(id <CCDirectedGraph>)dg usingQueue:(NSMutableArray *)queue andMap:(NSMutableDictionary *)map {
    NSEnumerator *i = [[dg vertexSet] objectEnumerator];
    id vertex;
    while ((vertex = [i nextObject])) {
        NSInteger inDegree = [dg inDegreeOf:vertex];
        map[vertex] = @(inDegree);
        if (inDegree == 0) {
            [queue addObject:vertex];
        }
    };

    if ([queue count]) {
        return [queue lastObject];
    } else {
        return nil;
    }
}
@end
