// UIImage+Alpha.h
/*
 //     ___ __   ____  _   _________
 //   / __// /  / __ \| | / / __/ _ \
 //  / /  / /_ / /_/ /| |/ / _// , _/
 // /___//____/\____/_\___/___/_/|_|
 // --------Created by clover--------
 */


@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;
@end
