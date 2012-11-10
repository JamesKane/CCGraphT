//
//  CCDefaultEdge.m
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCDefaultEdge.h"

@implementation CCDefaultEdge
- (NSString *)description
{
    return [NSString stringWithFormat:@"(%@ : %@)", self.source, self.target];
}
@end
