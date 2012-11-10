//
//  CCAbstractGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGraph.h"

@interface CCAbstractGraph : NSObject <CCGraph>
- (BOOL)assertVertexExists:(id)vertex;
@end
