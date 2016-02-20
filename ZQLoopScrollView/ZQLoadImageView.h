//
//  ZQLoadImageView.h
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/20.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZQLoadImageView;

//typedef void(^ZQTapImageViewBlock)(ZQLoadImageView  *imageView);
typedef void(^ZQImageBlock)(UIImage *image);

@interface ZQLoadImageView : UIImageView

/**
 *  Set to YES and it will be animated when image is loaded from network.
 *  If it it loaded from disk, it will be ignored.
 *  Default is YES.
 */
@property (nonatomic, assign) BOOL animated;

/**
 *  Set the control to be circle.
 *  Default is NO.
 */
@property (nonatomic, assign) BOOL isCircle;

/**
 *  Get/Set the callback block when download the image finished.
 *
 *  @param image The image object from network or from disk.
 */
@property (nonatomic, copy) ZQImageBlock completion;

/**
 *  Get/Set the call back block when the image view is tapped.
 *
 *  @note Only when property tapImageViewBlock is setted, will it add a tap gesture.
 *        When set it to be nil, the tap gesture will be removed automatically.
 *
 *  @param imageView The event receiver.
 */
//@property (nonatomic, copy) ZQTapImageViewBlock tapImageViewBlock;

/**
 *  Use these methods to download image async.
 */
- (void)setImageWithURLString:(NSString *)url placeholderImage:(NSString *)placeholderImage;
- (void)setImageWithURLString:(NSString *)url placeholder:(UIImage *)placeholderImage;
- (void)setImageWithURLString:(NSString *)url
                  placeholder:(UIImage *)placeholderImage
                   completion:(void (^)(UIImage *image))completion;
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(NSString *)placeholderImage
                   completion:(void (^)(UIImage *image))completion;

- (void)cancelRequest;

@end
