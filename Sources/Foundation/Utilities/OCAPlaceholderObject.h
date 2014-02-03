//
//  OCAPlaceholderObject.h
//  Objective-Chain
//
//  Created by Martin Kiss on 3.2.14.
//  Copyright (c) 2014 Martin Kiss. All rights reserved.
//

#import "OCAObject.h"





@interface OCAPlaceholderObject : OCAObject



#define OCAPH(CLASS)                OCAPlaceholder(CLASS)
#define OCAPlaceholder(CLASS)       ((CLASS *)[[OCAPlaceholderObject alloc] initWithRepresentedClass:[CLASS class]])

- (instancetype)initWithRepresentedClass:(Class)class;

@property (atomic, readonly, strong) Class representedClass;



@end


