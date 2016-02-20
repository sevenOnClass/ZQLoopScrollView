//
//  ZQPageControl.m
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/20.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ZQPageControl.h"

@implementation ZQPageControl

- (instancetype)init {
    if (self = [super init]) {
        // To Do:
        // set any default properties here
        [self addTarget:self
                 action:@selector(onPageControlValueChanged:)
       forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void)onPageControlValueChanged:(ZQPageControl *)sender {
    if (self.valueChangedBlock) {
        self.valueChangedBlock(sender.currentPage);
    }
}

@end
