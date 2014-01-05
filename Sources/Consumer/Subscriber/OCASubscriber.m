//
//  OCASubscriber.m
//  Objective-Chain
//
//  Created by Martin Kiss on 30.12.13.
//  Copyright © 2014 Martin Kiss. All rights reserved.
//

#import "OCASubscriber.h"





@interface OCASubscriber ()


@property (OCA_atomic, readonly, copy) OCASubscriberValueHandler valueHandler;
@property (OCA_atomic, readonly, copy) OCASubscriberFinishHandler finishHandler;


@end










@implementation OCASubscriber





#pragma mark Creating Subscriber


- (instancetype)init {
    return [self initWithValueClass:nil valueHandler:nil finishHandler:nil];
}


- (instancetype)initWithValueClass:(Class)valueClass valueHandler:(OCASubscriberValueHandler)valueHandler finishHandler:(OCASubscriberFinishHandler)finishHandler {
    self = [super init];
    if (self) {
        self->_valueClass = valueClass;
        self->_valueHandler = valueHandler;
        self->_finishHandler = finishHandler;
    }
    return self;
}


+ (instancetype)subscribeClass:(Class)valueClass handler:(OCASubscriberValueHandler)valueHandler {
    return [[self alloc] initWithValueClass:valueClass valueHandler:valueHandler finishHandler:nil];
}


+ (instancetype)subscribeClass:(Class)valueClass handler:(OCASubscriberValueHandler)valueHandler finish:(OCASubscriberFinishHandler)finishHandler {
    return [[self alloc] initWithValueClass:valueClass valueHandler:valueHandler finishHandler:finishHandler];
}





#pragma mark Lifetime of Subscriber


- (void)consumeValue:(id)value {
    BOOL valid = [self validateObject:&value ofClass:self.valueClass];
    if ( ! valid) return;
    
    if (self->_valueHandler) self->_valueHandler(value);
}


- (void)finishConsumingWithError:(NSError *)error {
    if (self->_finishHandler) self->_finishHandler(error);
}





@end










@implementation OCAProducer (OCASubscriber)



- (OCAConnection *)subscribeClass:(Class)valueClass handler:(OCASubscriberValueHandler)valueHandler {
    return [self connectTo:[OCASubscriber subscribeClass:valueClass handler:valueHandler]];
}


- (OCAConnection *)subscribeClass:(Class)valueClass handler:(OCASubscriberValueHandler)valueHandler finish:(OCASubscriberFinishHandler)finishHandler {
    return [self connectTo:[OCASubscriber subscribeClass:valueClass handler:valueHandler finish:finishHandler]];
}



@end


