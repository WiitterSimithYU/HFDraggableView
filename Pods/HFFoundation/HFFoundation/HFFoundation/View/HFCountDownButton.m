//
//  HFCountDownButton.m
//  HFCountDownButton
//
//  Created by Henry on 29/09/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

#import "HFCountDownButton.h"

@interface HFCountDownButton()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger remainSeconds; ///< 剩余秒数
@end

@implementation HFCountDownButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self setupInitStatus];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self setupInitStatus];
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (!newWindow) {
        [self.timer invalidate];
    }
}

#pragma mark- event handler

- (void)didTouchButton:(HFCountDownButton *)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark- public M

- (void)startCountDown {
    [self.timer invalidate];
    
    self.enabled = NO;
    
    _remainSeconds = self.seconds;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(refreshButton)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopCountDown {
    [self.timer invalidate];
    
    self.timer = nil;
    
    self.enabled = YES;
    
    [self setTitle:nil forState:UIControlStateDisabled]; // 防止重新开始瞬间标题残留
 }

#pragma mark- private M

- (void)setupInitStatus {
    _seconds = 10;
    _countingTitleFormat = @"{remain} 秒后重新获取";
    [self addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self setNeedsLayout];
}

- (void)refreshButton {
    if (--_remainSeconds == 0) { // finish
        [self.timer invalidate];
        self.timer = nil;
        
        [self setTitle:nil forState:UIControlStateDisabled]; // 防止重新开始瞬间标题残留
        
        self.enabled = YES;
        
        if (self.finishBlock) {
            self.finishBlock();
        }
        return;
    }
    
    NSString *title = [self.countingTitleFormat stringByReplacingOccurrencesOfString:@"{remain}"
                                                                          withString:[NSString stringWithFormat:@"%tu", _remainSeconds]];
    [self setTitle:title forState:UIControlStateDisabled];
}
@end
