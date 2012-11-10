//
//  CCIntrusiveEdge.h
//  CCGraphT
//
//  Created by James Kane on 11/9/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCIntrusiveEdge : NSObject <NSCopying>
@property (weak, nonatomic) id source;
@property (weak, nonatomic) id target;
@end