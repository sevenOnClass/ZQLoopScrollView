//
//  ZQLoopScrollView.h
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/20.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQLoadImageView.h"
#import "ZQPageControl.h"
#import "UIView+Extension.h"

/**
 *  The alignment type of page control. Only has two types.
 *  That is: center and right.
 */
typedef NS_ENUM(NSInteger, ZQPageControlAlignment) {

  /**
   *  For the center type, only show the page control without any text
   */
  kPageControlAlignCenter = 1 << 1,
  kPageControlAlignRight = 1 << 2
};

@class ZQLoopScrollView;

/**
 *  Call back method when an item was clicked at some time.
 *
 *  @param atIndex  The index of the clicked item in the loop scroll view
 */
typedef void (^ZQLoopScrollViewDidSelectItemBlock)(NSInteger atIndex,
                                                   ZQLoadImageView *sender);
/**
 *  Call back method when an item was clicked at some time.
 *
 *  @param atIndex  The index of the clicked item in the loop scroll view
 */
typedef void (^ZQLoopScrollViewDidScrollBlock)(NSInteger toIndex,
                                               ZQLoadImageView *sender);

@interface ZQLoopScrollView : UIView
/**
 *  The holder image for the image view. Default is nil
 */
@property(nonatomic, strong) UIImage *placeholder;


/**
 *  The alignment type of the page control.
 *
 *  @note The default type is kPageControlAlignCenter
 */
@property (nonatomic, assign) ZQPageControlAlignment alignment;

/**
 *  The image urls.It can be absolute urls or main bundle image names, even a
 * real UIImage object.
 */
@property(nonatomic, strong) NSArray *imageUrls;

/**
 *  Get/Set whether page control can handle value changed event.
 *
 *  @note Set to YES, page control will change to relevant page when clicked.
 *        Set to NO, page control is not enabled.
 *        Default is YES.
 */
@property (nonatomic, assign) BOOL pageControlEnabled;

/**
 *  The ad titles. Only for the alignment kPageControlAlignRight type.
 *
 *  @note If alignment == kPageControlAlignRight, it should be not nil.
 *        Otherwise it will be ignored whatever it is.
 */
@property (nonatomic, strong) NSArray *adTitles;

/**
 *  The interval time for the timer call. It means that you can
 *  specify a real time for the interval of ad.
 *
 *  @note The default time interval is 5.0
 */
@property(nonatomic, assign) NSTimeInterval timeInterval;

/**
 *  The call back method of item clicked
 */
@property (nonatomic, copy) ZQLoopScrollViewDidSelectItemBlock didSelectItemBlock;

/**
 *  The call back method when scroll to a new item
 */
@property (nonatomic, copy) ZQLoopScrollViewDidScrollBlock didScrollBlock;

/**
 *  The only created method for creating an object.
 *
 *  @param frame     The frame for the loop scroll view
 *  @param imageUrls image urls or image names or a real image object, you can
 * mix together.
 *
 *  @return The ZQLoopScrollView object.
 */
+ (instancetype)loopScrollViewWithFrame:(CGRect)frame
                              imageUrls:(NSArray *)imageUrls;
+ (instancetype)
loopScrollViewWithFrame:(CGRect)frame
              imageUrls:(NSArray *)imageUrls
           timeInterval:(NSTimeInterval)timeInterval
              didSelect:(ZQLoopScrollViewDidSelectItemBlock)didSelect
              didScroll:(ZQLoopScrollViewDidScrollBlock)didScroll;

/**
 *  Pause the timer. Usually you need to pause the timer when the view
 * disappear.
 */
- (void)pauseTimer;
/**
 *  Start the timer immediately. If you has pause the timer, you may need to
 * start
 *  the timer again when the view appear.
 */
- (void)startTimer;

/**
 * Set the color of pageControl tintColor.
 *
 */
-(void)setPageControlTintColor:(UIColor *)color;
/**
 * Set the color of current pageControl tintColor.
 *
 */
-(void)setCurrentPageIndicatorTintColor:(UIColor *)color;
@end
