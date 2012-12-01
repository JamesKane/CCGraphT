//
//  CCDefaultGraphMapping.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDefaultGraphMapping.h"

@interface CCDefaultGraphMapping ()
@property(strong, nonatomic) NSMutableDictionary *graphMappingForward;
@property(strong, nonatomic) NSMutableDictionary *graphMappingReverse;
@property(strong, nonatomic) id <CCGraph> graph1;
@property(strong, nonatomic) id <CCGraph> graph2;
@end

@implementation CCDefaultGraphMapping
@synthesize graphMappingForward = _graphMappingForward;
@synthesize graphMappingReverse = _graphMappingReverse;
@synthesize graph1 = _graph1;
@synthesize graph2 = _graph2;

- (id)initWithMap:(NSMutableDictionary *)g1ToG2 toMap:(NSMutableDictionary *)g2ToG1 fromGraph:(id <CCGraph>)g1 toGraph:(id <CCGraph>)g2 {
    self = [super init];
    if (self) {
        self.graph1 = g1;
        self.graph2 = g2;
        self.graphMappingForward = g1ToG2;
        self.graphMappingReverse = g2ToG1;
    }

    return self;
}

- (id)getEdge:(id)edge correspondence:(BOOL)forward {
    id <CCGraph> sourceGraph, targetGraph;

    if (forward) {
        sourceGraph = self.graph1;
        targetGraph = self.graph2;
    } else {
        sourceGraph = self.graph2;
        targetGraph = self.graph1;
    }

    id mappedSourceVertex = [self getVertex:[sourceGraph edgeSource:edge] correspondence:forward];
    id mappedTargetVertex = [self getVertex:[sourceGraph edgeTarget:edge] correspondence:forward];

    if (!mappedSourceVertex || !mappedTargetVertex) {
        return nil;
    } else {
        return [targetGraph edgeConnecting:mappedSourceVertex to:mappedTargetVertex];
    }
}

- (id)getVertex:(id)vertex correspondence:(BOOL)forward {
    NSMutableDictionary *graphMapping = forward ? self.graphMappingForward : self.graphMappingReverse;
    return graphMapping[vertex];
}
@end
