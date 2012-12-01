//
//  CCBreadthFirstIterator.m
//  CCGraphT
//
//  Created by James Kane on 11/16/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCBreadthFirstIterator.h"

@interface CCBreadthFirstIterator ()
@property(strong, nonatomic) NSMutableArray *queue;
@end

@implementation CCBreadthFirstIterator

- (id)initWithGraph:(CCAbstractBaseGraph *)graph {
    return [self initWithGraph:graph startFrom:nil];
}

- (id)initWithGraph:(CCAbstractGraph *)graph startFrom:(id)startVertex {
    self = [super initWithGraph:graph startFrom:startVertex];
    if (self) {
        self.queue = [NSMutableArray array];
    }

    return self;
}

- (BOOL)isConnectedComponentExhausted {
    return [self.queue count] == 0;
}

- (void)encounterVertex:(id)vertex with:(id)edge {
    [self putSeenData:[NSNull null] withKey:vertex];
    [self.queue addObject:vertex];
}

- (id)provideNextVertex {
    id result = (self.queue)[0];
    [self.queue removeObject:result];
    return result;
}

@end
