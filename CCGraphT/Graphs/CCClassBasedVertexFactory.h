//
//  CCClassBasedVertexFactory.h
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCVertexFactory.h"

@interface CCClassBasedVertexFactory : NSObject <CCVertexFactory>

- (id)initWithVertexClass:(Class)vertexClass;

@end
