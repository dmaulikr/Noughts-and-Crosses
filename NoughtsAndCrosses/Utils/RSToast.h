//
// RSToast.h
// Noughts & Crosses. Version 0.9
// Created by Rafal Sroka on 30.10.2011.
//
// This code is distributed under the terms and conditions of the MIT license.
// Copyright (c) 2011 Rafal Sroka
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

/**
 Notification component - an equivalent of Android's Toast.
 */
@interface RSToast : UIView {

    UIImageView *backgroundView;
    UILabel *textLabel;
    
    CGFloat opacity;
}

@property(nonatomic, retain) UIImageView *backgroundView;
@property(nonatomic, retain) UILabel *textLabel;
@property(nonatomic, assign) CGFloat opacity;

+(void)showInView:(UIView *)view withText:(NSString *)text animated:(BOOL)animated;

/**
 Returns an autoreleased RSToast with given message text.
 @param text the message text that will be shown in the Toast.
 @returns a newly initialized autoreleased RSToast.
 */
+(RSToast *)toastWithText:(NSString *)text;

/**
 Conveniant method that simplifies showing the Toast. Toast is automatically shown and removed from the view after the default amount of time.
 @param view the view in which the Toast will be shown.
 @param location the location of the center of the Toast.
 @param text the message text that will be shown in the Toast.
 @param animated the flag specifying whether the appearing of the Toast should be animated.
 */
+(void)showInView:(UIView *)view atLocation:(CGPoint)location withText:(NSString *)text animated:(BOOL)animated;

/**
 Sets default fint size of the message shown in Toast.
 @param fontSize the size of the font.
 */
+(void)setDefaultFontSize:(CGFloat )fontSize;

/**
 Hides the Toast.
 @param animated the flag specifying whether the disappearing of the Toast should be animated 
 */
-(void)hideAnimated:(NSNumber *)animated;

@end
