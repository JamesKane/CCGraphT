//
//  CCDijkstraShortestPath.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGraph.h"
#import "CCGraphPath.h"

@interface CCDijkstraShortestPath : NSObject
+ (NSArray *)findPathBetween:(id<CCGraph>)graph withOrigin:(id)startVertex andDesitination:(id)endVertex;

- (id)initWith:(id<CCGraph>)graph withOrigin:(id)startVertex andDesitination:(id)endVertex;
- (id)initWith:(id<CCGraph>)graph withOrigin:(id)startVertex andDesitination:(id)endVertex withRadius:(double)radius;
- (void)execute;
- (NSArray *)pathEdgeList;
- (id<CCGraphPath>)path;
- (double)pathLength;
@end
