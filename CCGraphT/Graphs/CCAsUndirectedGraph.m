//
//  CCAsUndirectedGraph.m
//  CCGraphT
//
//  Created by James Kane on 11/22/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import "CCAsUndirectedGraph.h"

static NSString *AUG_NO_EDGE_ADD = @"this graph does not support edge addition";
static NSString *AUG_UNDIRECTED = @"this graph only supports undirected operations";

@implementation CCAsUndirectedGraph

- (NSArray *)allEdgesConnecting:(id)sourceVertex to:(id)targetVertex {
    NSArray *forwardList = [super allEdgesConnecting:sourceVertex to:targetVertex];

    if ([sourceVertex isEqual:targetVertex]) {
        return forwardList;
    }

    NSArray *reverseList = [super allEdgesConnecting:targetVertex to:sourceVertex];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[forwardList count] + [reverseList count]];
    [result addObjectsFromArray:forwardList];
    [result addObjectsFromArray:reverseList];
    return result;
}

- (id)edgeConnecting:(id)sourceVertex to:(id)targetVertex {
    id edge = [super edgeConnecting:sourceVertex to:targetVertex];

    if (edge != nil)
        return edge;

    return [super edgeConnecting:targetVertex to:sourceVertex];
}

- (id)createEdgeFromVertex:(id)sourceVertex toVertex:(id)targetVertex {
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:AUG_NO_EDGE_ADD userInfo:nil];
}

- (BOOL)addEdge:(id)edge fromVertex:(id)sourceVertex toVertex:(id)targetVertex {
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:AUG_NO_EDGE_ADD userInfo:nil];
}

- (NSInteger)degreeOf:(id)vertex {
    return [super inDegreeOf:vertex] + [super outgoingDegreeOf:vertex];
}

- (NSInteger)inDegreeOf:(id)vertex {
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:AUG_UNDIRECTED userInfo:nil];
}

- (NSArray *)incomingEdgesOf:(id)vertex {
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:AUG_UNDIRECTED userInfo:nil];
}

- (NSInteger)outgoingDegreeOf:(id)vertex {
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:AUG_UNDIRECTED userInfo:nil];
}

- (NSArray *)outgoingEdgesOf:(id)vertex {
    @throw [NSException exceptionWithName:@"UnsupportedOperationException" reason:AUG_UNDIRECTED userInfo:nil];
}
@end
