//
//  RSToast.m
//  Noughts & Crosses. Version 0.9
//  Created by Rafal Sroka on 30.10.2011.
//
//  This code is distributed under the terms and conditions of the MIT license.
//  Copyright (c) 2011 Rafal Sroka
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "RSToast.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat defaultFontSize = 16;




@implementation RSToast
@synthesize backgroundView, textLabel, opacity;

+(void)setDefaultFontSize:(CGFloat )fontSize {
    
    defaultFontSize = fontSize;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        textLabel = [[UILabel alloc] initWithFrame:frame];
        [textLabel setFont:[UIFont boldSystemFontOfSize:defaultFontSize]];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setTextAlignment:UITextAlignmentCenter];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        
        backgroundView = [[UIImageView alloc] initWithFrame:frame];
        [backgroundView setBackgroundColor:[UIColor darkGrayColor]];
        [backgroundView setAlpha:0.95f];
        [backgroundView.layer setCornerRadius:5.0];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:backgroundView];
        [self addSubview:textLabel];
        
    }
    return self;
}

+(RSToast *)toastWithText:(NSString *)text {

    CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:defaultFontSize]];
    CGFloat margin = 8.0f;
    
    RSToast *toast = [[RSToast alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 2*margin, textSize.height + 2*margin)];
    toast.textLabel.text = text;
    
    return [toast autorelease];
}

+(void)showInView:(UIView *)view atLocation:(CGPoint)location withText:(NSString *)text animated:(BOOL)animated {
    
    RSToast *toast = [RSToast toastWithText:text];
    [toast setAlpha:0.0f];
    [toast setCenter:location];
    [view addSubview:toast];
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
    }
    [toast setAlpha:1.0f];
    
    if (animated) [UIView commitAnimations];
    
    [toast performSelector:@selector(hideAnimated:) withObject:[NSNumber numberWithBool:animated] afterDelay:1.3f];
}

+(void)showInView:(UIView *)view withText:(NSString *)text animated:(BOOL)animated {
    
    RSToast *toast = [RSToast toastWithText:text];
    [toast setAlpha:0.0f];
    [toast setCenter:view.center];
    [view addSubview:toast];
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
    }
    [toast setAlpha:1.0f];
    
    if (animated) [UIView commitAnimations];
    
    [toast performSelector:@selector(hideAnimated:) withObject:[NSNumber numberWithBool:animated] afterDelay:1.3f];
}

-(void)hideAnimated:(NSNumber *)animated {

    BOOL hideWithAnim = [animated boolValue];
    
    if (!hideWithAnim) {
        [self removeFromSuperview];
    }
    else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
        [self setAlpha:0.0f];
        
        [UIView commitAnimations];
    }
}

- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void*)context {
    [self removeFromSuperview];
}

-(void)dealloc {

    [backgroundView release];
    [textLabel release];
    [super dealloc];
}

@end
