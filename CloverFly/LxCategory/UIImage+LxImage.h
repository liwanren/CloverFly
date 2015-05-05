//
//  UIImage+LxImage.h
/*
 //     ___ __   ____  _   _________
 //   / __// /  / __ \| | / / __/ _ \
 //  / /  / /_ / /_/ /| |/ / _// , _/
 // /___//____/\____/_\___/___/_/|_|
 // --------Created by clover--------
 */



#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>


@interface UIImage (LxImage)


// 0.0 to 1.0
- (UIImage*)blurredImage:(CGFloat)blurAmount;



+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)screenshot;


- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;



@end
