//
//  HFTapImageView.h
//  HFFoundation
//
//  Created by Henry on 10/9/16.
//  Copyright © 2016 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapAction)(id obj);

@interface HFTapImageView : UIImageView

- (void)addTapBlock:(tapAction)tapAction;

@end
