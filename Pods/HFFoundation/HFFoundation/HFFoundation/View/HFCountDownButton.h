//
//  HFCountDownButton.h
//  HFCountDownButton
//
//  Created by Henry on 29/09/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface HFCountDownButton : UIButton
@property (nonatomic, assign) NSUInteger seconds; ///< 倒计时秒数

@property (nonatomic, copy) NSString *countingTitleFormat; ///< 倒计时标题，秒数使用 {remain} 替换

@property (nonatomic, copy) void(^clickBlock)(); ///< 点击
@property (nonatomic, copy) void(^startBlock)(); ///< 开始倒计时
@property (nonatomic, copy) void(^countingDownBlock)(NSUInteger remain); ///< 正在倒计时
@property (nonatomic, copy) void(^finishBlock)(); ///< 倒计时结束

- (void)startCountDown;
- (void)stopCountDown;
@end
NS_ASSUME_NONNULL_END
