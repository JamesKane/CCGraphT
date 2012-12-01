//
//  CCMaskSubgraph.m
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCMaskSubgraph.h"

static NSString *MS_UNMODIFIABLE = @"this graph is unmodifiable";

@interface CCMaskSubgraph ()
@property(strong, nonatomic) id <CCGraph> base;
@property(strong, nonatomic) NSSet *set;
@property(strong, nonatomic) id <CCMaskFunctor> mask;
@property(strong, nonatomic) NSSet *vertices;
@end

@implementation CCMaskSubgraph
@synthesize base = _base;
@synthesize set = _set;
@synthesize mask = _mask;
@synthesize vertices = _vertices;

- (id)initWithGraph:(id <CCGraph>)base andMask:(id <CCMaskFunctor>)mask {
    self = [super init];
    if (self) {
        self.base = base;
        self.mask = mask;
    }

    return self;
}
@end
