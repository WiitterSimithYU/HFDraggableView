//
//  NSArray+HFFoundation.h
//  HFFoundation
//
//  Created by Henry on 10/9/16.
//  Copyright © 2016 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HFFoundation)

@end


@interface NSMutableArray (HFFoundation)

@end


@interface NSMutableArray (HFFoundation_Sort)
- (void)hf_moveObjectAtIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex;
@end
