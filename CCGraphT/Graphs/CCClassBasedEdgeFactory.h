//
//  CCClassBasedEdgeFactory.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCEdgeFactory.h"

@interface CCClassBasedEdgeFactory : NSObject <CCEdgeFactory>
- (id)initWithEdgeClass:(Class)edgeClass;
@end
