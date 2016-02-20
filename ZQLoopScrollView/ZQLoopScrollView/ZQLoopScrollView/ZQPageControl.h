//
//  ZQPageControl.h
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/20.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQPageControl : UIPageControl

/**
 *  The call back when click a page control to switch to another page.
 *
 *  @param clickAtIndex The index clicked
 */
typedef void (^ZQPageControlValueChangedBlock)(NSInteger clickAtIndex);

/**
 *  It is not required. If you don't want to handle it, just ignore.
 */
@property (nonatomic, copy) ZQPageControlValueChangedBlock valueChangedBlock;
@end

