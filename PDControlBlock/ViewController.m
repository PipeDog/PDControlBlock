//
//  ViewController.m
//  PDControlBlock
//
//  Created by liang on 2018/10/8.
//  Copyright © 2018 PipeDog. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Block.h"
#import "UIGestureRecognizer+Block.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.button addActionForControlEvents:UIControlEventTouchUpInside usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"111111");
    }];

    [self.button addActionForControlEvents:UIControlEventTouchUpInside usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"222222");
    }];
    
    [self.button removeActionsForControlEvents:UIControlEventTouchUpInside];

    [self.button addActionForControlEvents:UIControlEventTouchUpInside usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"333333");
    }];
    
    [self.button addActionForControlEvents:UIControlEventTouchUpInside usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"444444");
    }];
    
    
    [self.button addActionForControlEvents:UIControlEventTouchDown usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"---111111");
    }];
    
    [self.button removeActionsForControlEvents:UIControlEventTouchDown];

    [self.button addActionForControlEvents:UIControlEventTouchDown usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"---222222");
    }];
    
    [self.button addActionForControlEvents:UIControlEventTouchDown usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"---333333");
    }];
    
    [self.button addActionForControlEvents:UIControlEventTouchDown usingBlock:^(__kindof UIControl * _Nonnull control) {
        NSLog(@"---444444");
    }];
    
//    [self.button removeAllActions];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionUsingBlock:^(UIGestureRecognizer * _Nonnull sender) {
        NSLog(@"sender.state = %zd", sender.state);
    }];
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:pan];
    
    [pan addActionUsingBlock:^(UIGestureRecognizer * _Nonnull sender) {
        NSLog(@"0000 pan.state = %zd", sender.state);
    }];
    
    [pan addActionUsingBlock:^(UIGestureRecognizer * _Nonnull sender) {
        NSLog(@"1111 pan.state = %zd", sender.state);
    }];
    
    [pan addActionUsingBlock:^(UIGestureRecognizer * _Nonnull sender) {
        NSLog(@"2222 pan.state = %zd", sender.state);
    }];
    
    [pan removeAllActions];
}

@end
