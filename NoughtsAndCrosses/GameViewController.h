//
//  GameViewController.h
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

#import <UIKit/UIKit.h>
#import "Game.h"

/**
 Class to present and manage game interface.
 */
@class FieldButton;
@interface GameViewController : UIViewController <GameDelegate, UIActionSheetDelegate>{

    /**
     A view on which game board is shown
     */
    IBOutlet UIView *gameView;
    
    /**
     Game instance.
     */
    Game *game;
}

@property(nonatomic, retain) Game *game;
@property(nonatomic, retain) IBOutlet UIView *gameView;

/**
 Action sent by field buttons upon the UITouchUpInside event.
 @param sender the sender object that invoked the action.
 */
-(IBAction)tappedFieldWithButton:(id)sender;

/**
 Shows an alert with information.
 @param sender the sender object that invoked the action.
 */
-(void)infoAction:(id)sender;

/**
 Starts a new game.
 @param sender the sender object that invoked the action.
 */
-(void)newGameAction:(id)sender;

/**
 Performs shake style shaking animation with the given view.
 @param itemView the view that will be shaken.
 */
-(void)shake:(UIView*)itemView;

/**
 Gets a FieldButton instance with the location on the game board given.
 @param location the location of the item on the game board (The location must be specified in Boards coordinates - column and row).
 @returns FieldButton instance.
 */
-(FieldButton *)fieldForLocation:(CGPoint)location;

@end