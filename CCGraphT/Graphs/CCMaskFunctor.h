//
//  CCMaskFunctor.h
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCMaskFunctor

- (BOOL)isEdgeMasked:(id)edge;

- (BOOL)isVertexMasked:(id)vertex;

@end
