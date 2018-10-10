//
//  UIControl+Block.m
//  PDControlBlock
//
//  Created by liang on 2018/10/8.
//  Copyright © 2018 PipeDog. All rights reserved.
//

#import "UIControl+Block.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<void (^)(__kindof UIControl *)> *> *allActions;

@end

@implementation UIControl (Block)

static void eventHandlerImpl(id self, SEL op, id target) {
    NSString *selName = NSStringFromSelector(op);
    NSUInteger toIndex = [selName rangeOfString:@":"].location;
    NSUInteger fromIndex = @"eventHandler_".length;
    
    NSString *eventKey = [selName substringWithRange:NSMakeRange(fromIndex, toIndex - fromIndex)];
    
    UIControl *control = (UIControl *)self;
    NSMutableArray<void (^)(__kindof UIControl *)> *actionsForControlEvents = control.allActions[@([eventKey integerValue])];
    
    for (void (^block)(UIControl *) in actionsForControlEvents) {
        if (block) block(control);
    }
}

- (void)addActionForControlEvents:(UIControlEvents)controlEvents usingBlock:(void (^)(__kindof UIControl * _Nonnull))block {
    if (!block) {
        return;
    }

    NSMutableArray<void (^)(__kindof UIControl *)> *actionsForControlEvents = self.allActions[@(controlEvents)];
    
    if (!actionsForControlEvents) {
        actionsForControlEvents = [NSMutableArray array];
        
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"eventHandler_%lu:", controlEvents]);
        class_addMethod([self class], sel, (IMP)eventHandlerImpl, "v@:@");
        [self addTarget:self action:sel forControlEvents:controlEvents];
    }
    
    [actionsForControlEvents addObject:[block copy]];
    self.allActions[@(controlEvents)] = actionsForControlEvents;
}

- (void)removeActionsForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray<void (^)(__kindof UIControl *)> *actionsForControlEvents = self.allActions[@(controlEvents)];
    if (!actionsForControlEvents.count) return;
    
    [actionsForControlEvents removeAllObjects];
}

#pragma mark - Getter Methods
- (NSMutableDictionary<NSString *, NSMutableArray<void (^)(UIControl *)> *> *)allActions {
    NSMutableDictionary *allActions = objc_getAssociatedObject(self, _cmd);
    if (!allActions) {
        allActions = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, allActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return allActions;
}

@end
