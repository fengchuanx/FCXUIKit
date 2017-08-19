//
//  UIButton+Block.m
//  Universial
//
//  Created by 冯 传祥 on 15/8/16.
//  Copyright (c) 2015年 冯 传祥. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static char FCXButtonEventsBlockKey;

@implementation UIButton (Block)

- (void)actionWithControlEvents:(UIControlEvents)controlEvent handler:(void (^)(UIButton *button))handler {

    objc_setAssociatedObject(self, &FCXButtonEventsBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonAction) forControlEvents:controlEvent];
}

- (void)defaultControlEventsWithHandler:(void (^)(UIButton *button))handler {

    [self actionWithControlEvents:UIControlEventTouchUpInside handler:handler];
}

- (void)buttonAction {

   void (^buttonHandler)(UIButton *button) =  objc_getAssociatedObject(self, &FCXButtonEventsBlockKey);
    if (buttonHandler) {
        buttonHandler(self);
    }
}

@end
