//
//  CCWeightCombiner.h
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCWeightCombiner
- (double)combine:(double)a with:(double)b;
@end

@interface SumWeightCombiner : NSObject <CCWeightCombiner>
@end

@interface MaxWeightCombiner : NSObject <CCWeightCombiner>
@end

@interface MinWeightCombiner : NSObject <CCWeightCombiner>
@end

@interface FirstWeightCombiner : NSObject <CCWeightCombiner>
@end

@interface SecondWeightCombiner : NSObject <CCWeightCombiner>
@end