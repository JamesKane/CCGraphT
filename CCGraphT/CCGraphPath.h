//
//  CCGraphPath.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGraph.h"

@protocol CCGraphPath <NSObject>

- (id <CCGraph>)graph;

- (id)startVertex;

- (id)endVertex;

- (NSArray *)edgeList;

- (double)weight;

@end
