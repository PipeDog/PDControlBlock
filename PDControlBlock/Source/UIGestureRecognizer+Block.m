//
//  UIGestureRecognizer+Block.m
//  PDControlBlock
//
//  Created by liang on 2018/11/1.
//  Copyright © 2018 PipeDog. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>

@interface PDGestureActionWrapper : NSObject

@property (nonatomic, copy) void (^block)(__kindof UIGestureRecognizer *);

- (void)triggerAction:(UIGestureRecognizer *)sender;

@end

@implementation PDGestureActionWrapper

- (void)triggerAction:(UIGestureRecognizer *)sender {
    !self.block ?: self.block(sender);
}

@end

@interface UIGestureRecognizer ()

@property (nonatomic, strong) NSMutableArray<PDGestureActionWrapper *> *allWrappers;

@end

@implementation UIGestureRecognizer (Block)

- (instancetype)initWithActionUsingBlock:(void (^)(UIGestureRecognizer * _Nonnull))block {
    self = [self init];
    if (self) {
        [self addActionUsingBlock:block];
    }
    return self;
}

- (void)addActionUsingBlock:(void (^)(UIGestureRecognizer * _Nonnull))block {
    if (block) {
        PDGestureActionWrapper *wrapper = [[PDGestureActionWrapper alloc] init];
        wrapper.block = block;
        [self addTarget:wrapper action:@selector(triggerAction:)];
        
        [self.allWrappers addObject:wrapper];
    }
}

- (void)removeAllActions {
    if (!self.allWrappers.count) return;

    for (PDGestureActionWrapper *wrapper in self.allWrappers) {
        [self removeTarget:wrapper action:@selector(triggerAction:)];
    }
    
    [self.allWrappers removeAllObjects];
}

#pragma mark - Getter Methods
- (NSMutableArray<PDGestureActionWrapper *> *)allWrappers {
    NSMutableArray *_allWrappers = objc_getAssociatedObject(self, _cmd);
    if (!_allWrappers) {
        _allWrappers = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, _allWrappers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _allWrappers;
}

@end
