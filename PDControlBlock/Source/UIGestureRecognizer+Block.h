//
//  UIGestureRecognizer+Block.h
//  PDControlBlock
//
//  Created by liang on 2018/11/1.
//  Copyright © 2018 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (Block)

- (instancetype)initWithActionUsingBlock:(void (^ __nullable)(UIGestureRecognizer *sender))block;

- (void)addActionUsingBlock:(void (^ __nullable)(UIGestureRecognizer *sender))block;

- (void)removeAllActions;

@end

NS_ASSUME_NONNULL_END
