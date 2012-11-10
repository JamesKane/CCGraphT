//
//  CCEdgeSetFactory.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCEdgeSetFactory <NSObject>
- (NSMutableSet *)createEdgeSet:(id)vertex;
@end
