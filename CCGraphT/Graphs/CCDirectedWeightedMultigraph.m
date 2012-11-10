//
//  CCDirectedWeightedMultigraph.m
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDirectedWeightedMultigraph.h"
#import "CCClassBasedEdgeFactory.h"

@implementation CCDirectedWeightedMultigraph

- (id)initWithEdgeFactory:(id<CCEdgeFactory>)ef
{
    return [super initWithEdgeFactory:ef];
}

@end
