//
//  CCWeightCombiner.m
//  CCGraphT
//
//  Created by James Kane on 11/17/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCWeightCombiner.h"

@implementation SumWeightCombiner
- (double)combine:(double)a with:(double)b { return a + b; }
@end

@implementation MaxWeightCombiner
- (double)combine:(double)a with:(double)b { return MAX(a, b); }
@end

@implementation MinWeightCombiner
- (double)combine:(double)a with:(double)b { return MIN(a, b); }
@end

@implementation FirstWeightCombiner
- (double)combine:(double)a with:(double)b { return a; }
@end

@implementation SecondWeightCombiner
- (double)combine:(double)a with:(double)b { return b; }
@end
