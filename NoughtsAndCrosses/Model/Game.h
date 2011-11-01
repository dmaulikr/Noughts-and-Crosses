//
//  Game.h
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
#import <Foundation/Foundation.h>
#import "Board.h"
#import "GameDelegate.h"

/**
 Class to represent a single skirmish of Noughts and Crosses.  
 */
@interface Game : NSObject {
    
    /**
     Game board.
     */
    Board *board;
    
    /**
     Delegate instance conforming to GameDelegate formal protocol. Delegate is informed about any change in game progress.
     */
    id<GameDelegate> delegate;
    
    /**
     Type of the item that will perform the next move.
     */
    ItemType itemTypeToMove;
    
    /**
     A flag indicating the state of the game.
     */
    BOOL isOver;
    
    /**
     The number of moves users already performed.
     */
    int movesCount;
}

@property(nonatomic, retain) Board *board;
@property(nonatomic, assign) id<GameDelegate> delegate;
@property(nonatomic, assign) ItemType itemTypeToMove;

/**
 Update the field at the specified location on the game board.
 @param location the location of the item that will be updated.
 */
-(void)updateFieldAtLocation:(CGPoint)location;

/**
 Check whether the game is finished.
 @returns YES if the game is over.
 */
-(BOOL)isOver;

/**
 Create a new game. All previous game progress will be lost.
 */
-(void)create;

/**
 Check whether Crosses or Noughts won.
 @returns YES if Crosses or Noughts won.
 */
-(BOOL)check;

/**
 Check whether Crosses or Noughts won or a tie occured and inform the delegate.
 @param location the location of the item that will be updated.
 */
-(void)checkWithLocation:(CGPoint)location;

@end
