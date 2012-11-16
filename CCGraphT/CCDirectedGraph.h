//
//  CCDirectedGraph.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCDirectedGraph <NSObject>
- (NSInteger)inDegreeOf:(id)vertex;
- (NSArray *)incomingEdgesOf:(id)vertex;
- (NSInteger)outgoingDegreeOf:(id)vertex;
- (NSArray *)outgoingEdgesOf:(id)vertex;
@end
