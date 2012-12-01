//
//  CCClassBasedVertexFactory.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCClassBasedVertexFactory.h"

@interface CCClassBasedVertexFactory ()
@property(nonatomic) Class vertexClass;
@end

@implementation CCClassBasedVertexFactory

- (id)initWithVertexClass:(Class)vertexClass {
    self = [super init];
    if (self) {
        self.vertexClass = vertexClass;
    }
    return self;
}

- (id)createVertex {
    return [[[self.vertexClass class] alloc] init];
}

@end
