//
//  CCMaskEdgeSet.h
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMaskFunctor.h"
#import "CCGraph.h"

@interface CCMaskEdgeSet : NSMutableSet

- (id)initWithGraph:(id <CCGraph>)graph usingEdges:(NSSet *)edgeSet applyingMask:(id <CCMaskFunctor>)mask;

@end
