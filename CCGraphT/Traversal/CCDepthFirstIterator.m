//
//  CCDepthFirstIterator.m
//  CCGraphT
//
//  Created by James Kane on 11/13/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDepthFirstIterator.h"

@interface CCDepthFirstIterator () {
    NSMutableArray *stack;
}

@end

@implementation CCDepthFirstIterator

- (id)initWithGraph:(CCAbstractBaseGraph *)graph {
    return [self initWithGraph:graph startFrom:nil];
}

- (id)initWithGraph:(CCAbstractGraph *)graph startFrom:(id)startVertex {
    self = [super initWithGraph:graph startFrom:startVertex];
    if (self) {
        stack = [NSMutableArray array];
    }

    return self;
}

- (BOOL)isConnectedComponentExhausted {
    while (YES) {
        if ([stack count] == 0) {
            return YES;
        }

        if ([stack lastObject] != [NSNull null]) {
            return NO;
        }

        [stack removeLastObject];
        [self recordFinish];
    }
}

- (void)encounterVertex:(id)vertex with:(id)edge {
    [self putSeenData:@(WHITE) withKey:vertex];
    [stack addObject:vertex];
}

- (void)encounterVertexAgain:(id)vertex with:(id)edge {
    VisitColor color = (VisitColor) [((NSNumber *) [self seenData:vertex]) intValue];
    if (color != WHITE) {
        return;
    }

    [stack removeObject:vertex];
    [stack addObject:vertex];
}

- (id)provideNextVertex {
    id v;
    while (YES) {
        v = [stack lastObject];
        [stack removeLastObject];
        if (v == [NSNull null]) {
            [self recordFinish];
        } else {
            break;
        }
    }

    [stack addObject:v];
    [stack addObject:[NSNull null]];
    [self putSeenData:@(GRAY) withKey:v];
    return v;
}

- (void)recordFinish {
    id v = [stack lastObject];
    [stack removeLastObject];
    [self putSeenData:@(BLACK) withKey:v];
    [self finishVertex:v];
}
@end
