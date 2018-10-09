//
//  UIControl+Block.h
//  PDControlBlock
//
//  Created by liang on 2018/10/8.
//  Copyright © 2018 PipeDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Block)

/// Invoke method [- addEventHandler:forControlEvents:replaceBefore:], param replaceBefore is YES.
- (void)addEventHandler:(void (^)(__kindof UIControl *control))eventHandler forControlEvents:(UIControlEvents)controlEvents;

/// If replaceLast is YES, remove last registered eventHandler and append the new eventHandler.
/// If replaceLast is NO, append the new eventHandler and keep the old eventHandler.
- (void)addEventHandler:(void (^)(__kindof UIControl *control))eventHandler forControlEvents:(UIControlEvents)controlEvents replaceLast:(BOOL)replaceLast;

/// Remove registered eventHandlers for controlEvents.
- (void)removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
