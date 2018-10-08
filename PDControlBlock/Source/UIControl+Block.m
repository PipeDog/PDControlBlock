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

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<void (^)(__kindof UIControl *)> *> *eventHandlers;

@end

@implementation UIControl (Block)

static void eventHandlerImpl(id self, SEL op, id target) {
    NSString *selName = NSStringFromSelector(op);
    NSUInteger toIndex = [selName rangeOfString:@":"].location;
    NSUInteger fromIndex = @"eventHandler_".length;
    
    NSString *eventKey = [selName substringWithRange:NSMakeRange(fromIndex, toIndex - fromIndex)];
    
    UIControl *control = (UIControl *)self;
    NSMutableArray<void (^)(__kindof UIControl *)> *eventHandlers = control.eventHandlers[eventKey];
    
    for (void (^eventHandler)(UIControl *) in eventHandlers) {
        if (eventHandler) eventHandler(control);
    }
}

- (void)addEventHandler:(void (^)(__kindof UIControl * _Nonnull))eventHandler forControlEvents:(UIControlEvents)controlEvents {
    [self addEventHandler:eventHandler forControlEvents:controlEvents replaceBefore:YES];
}

- (void)addEventHandler:(void (^)(__kindof UIControl * _Nonnull))eventHandler forControlEvents:(UIControlEvents)controlEvents replaceBefore:(BOOL)replaceBefore {
    
    NSString *eventKey = [NSString stringWithFormat:@"%lu", controlEvents];
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"eventHandler_%lu:", controlEvents]);
    
    NSMutableArray<void (^)(__kindof UIControl *)> *eventHandlers = self.eventHandlers[eventKey];
    
    if (!eventHandlers) {
        eventHandlers = [NSMutableArray array];
        
        class_addMethod([self class], sel, (IMP)eventHandlerImpl, "v@:@");
        [self addTarget:self action:sel forControlEvents:controlEvents];
    }
    
    if (replaceBefore) {
        [eventHandlers removeAllObjects];
    }
    
    [eventHandlers addObject:[eventHandler copy]];
    self.eventHandlers[eventKey] = eventHandlers;
}

#pragma mark - Getter Methods
- (NSMutableDictionary<NSString *,void (^)(UIControl *)> *)eventHandlers {
    NSMutableDictionary *eventHandlers = objc_getAssociatedObject(self, _cmd);
    if (!eventHandlers) {
        eventHandlers = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, eventHandlers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return eventHandlers;
}

@end
