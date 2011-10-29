//
//  GameViewController.m
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

#import "GameViewController.h"
#import "FieldButton.h"
#import "Game.h"
#import "RSToast.h"
#import <QuartzCore/QuartzCore.h>

@implementation GameViewController
@synthesize game;

#pragma mark -
#pragma mark UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self newGameAction:nil];
            break;
        case 1:
            [self infoAction:nil];
            break;
        default:
            break;
    }}

#pragma mark -
#pragma mark Interface actions

-(void)showMenuActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"", @"") 
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"") 
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"New Game", @""), NSLocalizedString(@"About", @""), nil];
    
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction)tappedFieldWithButton:(id)sender {
    FieldButton *field = (FieldButton *)sender;
    
    if ([game isOver]) {
        [self earthquake:field];
    }
    else {
        [game updateFieldAtLocation:field.location];
    }
}

-(void)infoAction:(id)sender {
    
    UIAlertView *info = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"About", @"") 
                                                   message:NSLocalizedString(@"Copyright 2011 Rafał Sroka. All rights reserved.", @"") 
                                                  delegate:nil
                                         cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                         otherButtonTitles:nil];
    [info show];
    [info release];
}

-(void)newGameAction:(id)sender {
    
    [game create];
    CGFloat delay = 0.1;
    int fieldNumber = 0;
    
    for (FieldButton *possibleField in gameView.subviews) {

        [UIView beginAnimations:@"newgame" context:[NSNumber numberWithInt:++fieldNumber]];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelay:delay+=0.2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:possibleField cache:YES];
        [possibleField setImage:nil forState:UIControlStateNormal];
        
        [UIView commitAnimations];
    }
}

- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void*)context {
    
    if ([animationID isEqualToString:@"newgame"]) {
        
        NSNumber *fieldNumber = (NSNumber *)context;
        
        if ([fieldNumber intValue] == 9) {
            [RSToast showInView:self.view 
                     atLocation:CGPointMake(self.view.center.x, gameView.frame.origin.y - 30) 
                       withText:NSLocalizedString(@"New game. Noughts start.", @"") animated:YES];
        }
    }
}

#pragma mark -
#pragma mark Game delegate

-(void)game:(Game *)game didFinishWithWinningItem:(ItemType)itemType {
    
    NSString *message = nil;
    NSString *title = nil;
    
    switch (itemType) {
        case ItemTypeCross:
            title = NSLocalizedString(@"Crosses win!", @"");
            break;
        case ItemTypeNought:
            title = NSLocalizedString(@"Noughts win!", @"");
            break; 
        case ItemTypeUndefined:
            title = NSLocalizedString(@"Tie!", @"");
            break;
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:message
                                                   delegate:nil 
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"") 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)game:(Game *)aGame didUpdateItemAtLocation:(CGPoint)point {
    
    FieldButton *field = [self fieldForLocation:point];
    NSString *toastMessage = nil;
    
    if (!field) return;
    
    [UIView beginAnimations:@"fieldflip" context:nil];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:field cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    
    switch (aGame.itemTypeToMove) {
        case ItemTypeCross:
            [field setImage:kCrossImage forState:UIControlStateNormal];
            toastMessage = NSLocalizedString(@"Noughts move", @"");
            
            break;
        case ItemTypeNought:
            [field setImage:kCircleImage forState:UIControlStateNormal];
            toastMessage = NSLocalizedString(@"Crosses move", @"");

            break;        
        default:
            break;
    }
    
    [UIView commitAnimations];
    
    if (toastMessage) [RSToast showInView:self.view atLocation:CGPointMake(self.view.center.x, gameView.frame.origin.y - 30) withText:toastMessage animated:YES];
}

#pragma mark -
#pragma mark Game

-(FieldButton *)fieldForLocation:(CGPoint)location {
    
    FieldButton *field = nil;
    
    for (FieldButton *possibleField in gameView.subviews) {
        
        if (possibleField.location.x == location.x && possibleField.location.y == location.y) {
            field = possibleField;
            break;
        }
    }
    
    return field;
}

-(void)setupGameboard {
    
    int padding = kGameFieldPadding;
    int x = padding;
    int y = padding;
    
   int fieldWidth = (gameView.frame.size.width - padding*(game.board.width +1))/game.board.width;
    
    for (int row = 0; row < game.board.height; row++) {
        
        for (int column = 0; column < game.board.width; column++) {
            
            FieldButton *field = [[FieldButton alloc] init];
            field.location = CGPointMake(row, column);
            
            [field setFrame:CGRectMake(x, y, fieldWidth, fieldWidth)];
            [field setBackgroundColor:[UIColor clearColor]];
            [field setBackgroundImage:[UIImage imageNamed:@"tile"] forState:UIControlStateNormal];
            [field addTarget:self action:@selector(tappedFieldWithButton:) forControlEvents:UIControlEventTouchUpInside];
            field.layer.shadowOpacity = 0.75;
            field.layer.shadowOffset = CGSizeMake(1, 1);
            field.layer.shadowColor = [[UIColor blackColor] CGColor];
 
            [gameView addSubview:field];
            [field release];
            
            x += fieldWidth + padding;
        }
        
        x = padding;
        y += fieldWidth + padding;
    }
}

#pragma mark -
#pragma mark Earthquake animations

-(void)earthquake:(UIView*)itemView {
    CGFloat t = 2.0;
	
    CGAffineTransform leftQuake  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, -t);
    CGAffineTransform rightQuake = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, t);
	
    itemView.transform = leftQuake;  // starting point
	
    [UIView beginAnimations:@"earthquake" context:itemView];
    [UIView setAnimationRepeatAutoreverses:YES]; // important
    [UIView setAnimationRepeatCount:5];
    [UIView setAnimationDuration:0.07];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(earthquakeEnded:finished:context:)];
	
    itemView.transform = rightQuake; // end here & auto-reverse
	
    [UIView commitAnimations];
}

-(void)earthquakeEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([finished boolValue]) {
        UIView* item = (UIView *)context;
        item.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - View lifecycle & deallocations

- (void)viewDidLoad {
    [super viewDidLoad];
    
    game = [[Game alloc] init];
    [game setDelegate:self];
    [self setupGameboard];
    
    self.title = NSLocalizedString(@"Noughts & Crosses", @"");
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                          target:self 
                                                                          action:@selector(showMenuActionSheet:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [game release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

@end