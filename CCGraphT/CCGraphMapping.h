//
//  CCGraphMapping.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGraphMapping <NSObject>

- (id)getVertex:(id)vertex correspondence:(BOOL)forward;
- (id)getEdge:(id)edge correspondence:(BOOL)forward;

@end
