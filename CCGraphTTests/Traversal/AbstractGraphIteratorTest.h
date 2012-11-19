//
//  AbstractGraphIteratorTest.h
//  CCGraphT
//
//  Created by James Kane on 11/12/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "CCDirectedGraph.h"
#import "CCAbstractGraphIterator.h"

@interface AbstractGraphIteratorTest : SenTestCase

- (NSString *)expectedFinishString;
- (id<CCDirectedGraph>)createDirectedGraph;
- (CCAbstractGraphIterator *)createIterator:(id<CCDirectedGraph>)g starting:(NSString *)startVertex;

- (NSString* )expectedStr1;
- (NSString* )expectedStr2;

@end
