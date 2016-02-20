//
//  UIView+Extension.m
//  ZQLoopScrollView
//
//  Created by 庄琦 on 16/2/18.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setZq_origin:(CGPoint)zq_origin {
    CGRect frame = self.frame;
    frame.origin = zq_origin;
    self.frame = frame;
}

- (CGPoint)zq_origin {
    return self.frame.origin;
}

- (void)setZq_originX:(CGFloat)zq_originX {
    self.zq_origin = CGPointMake(zq_originX, self.zq_originY);
}

- (CGFloat)zq_originX {
    return self.zq_origin.x;
}

- (void)setZq_originY:(CGFloat)zq_originY {
    self.zq_origin = CGPointMake(self.zq_originX, zq_originY);
}

- (CGFloat)zq_originY {
    return self.zq_origin.y;
}

- (void)setZq_rightX:(CGFloat)zq_rightX {
    CGRect frame = self.frame;
    frame.origin.x = zq_rightX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)zq_rightX {
    return self.zq_width + self.zq_originX;
}

- (void)setZq_width:(CGFloat)zq_width {
    CGRect frame = self.frame;
    frame.size.width = zq_width;
    self.frame = frame;
}

- (CGFloat)zq_width {
    return self.frame.size.width;
}

- (void)setZq_size:(CGSize)zq_size {
    CGRect frame = self.frame;
    frame.size = zq_size;
    self.frame = frame;
}

- (CGSize)zq_size {
    return self.frame.size;
}

- (void)setZq_height:(CGFloat)zq_height {
    CGRect frame = self.frame;
    frame.size.height = zq_height;
    self.frame = frame;
}

- (CGFloat)zq_height {
    return self.frame.size.height;
}

- (void)setZq_bottomY:(CGFloat)zq_bottomY {
    CGRect frame = self.frame;
    frame.origin.y = zq_bottomY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)zq_bottomY {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setZq_centerX:(CGFloat)zq_centerX {
    self.center = CGPointMake(zq_centerX, self.center.y);
}

- (CGFloat)zq_centerX {
    return self.center.x;
}

- (void)setZq_centerY:(CGFloat)zq_centerY {
    self.center = CGPointMake(self.center.x, zq_centerY);
}

- (CGFloat)zq_centerY {
    return self.center.y;
}

- (void)setZq_corneradus:(CGFloat)zq_corneradus {
    self.layer.cornerRadius = zq_corneradus;
}

- (CGFloat)zq_corneradus {
    return self.layer.cornerRadius;
}

- (void)setZq_borderColor:(UIColor *)zq_borderColor {
    self.layer.borderColor = zq_borderColor.CGColor;
}

- (UIColor *)zq_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setZq_borderWidth:(CGFloat)zq_borderWidth {
    self.layer.borderWidth = zq_borderWidth;
}

- (CGFloat)zq_borderWidth {
    return self.layer.borderWidth;
}
@end
