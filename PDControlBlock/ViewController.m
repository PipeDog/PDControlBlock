//
//  ViewController.m
//  PDControlBlock
//
//  Created by liang on 2018/10/8.
//  Copyright © 2018 PipeDog. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Block.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"-----111111");
    } forControlEvents:UIControlEventTouchDown];

    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"-----222222");
    } forControlEvents:UIControlEventTouchDown];

    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"-----333333");
    } forControlEvents:UIControlEventTouchDown];
    
    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"-----444444");
    } forControlEvents:UIControlEventTouchDown];

    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"111111");
    } forControlEvents:UIControlEventTouchUpInside replaceLast:NO];

    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"222222");
    } forControlEvents:UIControlEventTouchUpInside replaceLast:YES];
    
    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"333333");
    } forControlEvents:UIControlEventTouchUpInside replaceLast:YES];

    [self.button addEventHandler:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"444444");
    } forControlEvents:UIControlEventTouchUpInside replaceLast:NO];

//    [self.button removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
}

@end
