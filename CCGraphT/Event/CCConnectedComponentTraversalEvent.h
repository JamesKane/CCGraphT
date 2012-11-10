//
//  CCConnectedComponentTraversalEvent.h
//  CCGraphT
//
//  Created by James Kane on 11/10/12.
//  Copyright (c) 2012 James Kane. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CONNECTED_COMPONENT_EVENT_TYPE {
  CONNECTED_COMPONENT_STARTED = 31,
  CONNECTED_COMPONENT_FINISHED = 32
} ConnectedComponentEventType;

@interface CCConnectedComponentTraversalEvent : NSObject
@property (nonatomic, readonly) ConnectedComponentEventType type;
@property (nonatomic, weak, readonly) id source;

- (id)initWith:(id)source forEvent:(ConnectedComponentEventType)type;
@end
