//
//  CCGraphPathImpl.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGraphPath.h"

@interface CCGraphPathImpl : NSObject <CCGraphPath>

- (id)initWith:(id <CCGraph>)graph from:(id)startVertex to:(id)endVertex having:(NSArray *)edgeList with:(double)weight;

@end
