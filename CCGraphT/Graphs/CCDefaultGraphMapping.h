//
//  CCDefaultGraphMapping.h
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCGraphMapping.h"
#import "CCGraph.h"

@interface CCDefaultGraphMapping : NSObject <CCGraphMapping>

- (id)initWithMap:(NSMutableDictionary *)g1ToG2 toMap:(NSMutableDictionary *)g2ToG1 fromGraph:(id<CCGraph>)g1 toGraph:(id<CCGraph>)g2;

@end
