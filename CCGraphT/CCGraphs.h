//
//  CCGraphs.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGraph.h"

@interface CCGraphs : NSObject
+ (BOOL)addGraph:(id<CCGraph>)destination from:(id<CCGraph>)source;
+ (id)oppositeVertex:(id<CCGraph>)graph for:(id)edge from:(id)vertex;
@end
