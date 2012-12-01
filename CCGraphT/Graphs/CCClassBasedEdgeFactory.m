//
//  CCClassBasedEdgeFactory.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCClassBasedEdgeFactory.h"

@interface CCClassBasedEdgeFactory ()
@property(nonatomic) Class edgeClass;
@end

@implementation CCClassBasedEdgeFactory

- (id)initWithEdgeClass:(Class)edgeClass {
    if (self = [super init]) {
        self.edgeClass = edgeClass;
    }

    return self;
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex {
    return [[self.edgeClass alloc] init];
}

@end
