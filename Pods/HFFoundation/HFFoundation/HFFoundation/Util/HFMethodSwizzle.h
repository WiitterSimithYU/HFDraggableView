//
//  HFMethodSwizzle.h
//  HFFoundation
//
//  Created by Henry on 10/9/16.
//  Copyright © 2016 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void hf_methodSwizzle(Class cls, SEL originalSelector, SEL swizzledSelector);
