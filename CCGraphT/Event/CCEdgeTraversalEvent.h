//
//  CCEdgeTraversalEvent.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCEdgeTraversalEvent : NSObject
@property (strong, readonly, nonatomic) id source;
@property (strong, readonly, nonatomic) id edge;

- (id)initWithSource:(id)eventSource onEdge:(id)edge;
@end
