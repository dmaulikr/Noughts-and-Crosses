//
//  Game.m
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

#import "Game.h"
#define kMovesLimit 9

@implementation Game
@synthesize board, itemTypeToMove;
@synthesize delegate;

-(id)init {
    
    self = [super init];
    
    if (self) {
        [self create];
    }
    return self;
}

-(BOOL)isOver {
    return isOver;
}

-(void)create {

    movesCount = 0;
    self.board = [[Board alloc] initWithSize:CGSizeMake(3, 3)];
    itemTypeToMove = ItemTypeCross; // cross starts
    isOver = NO;
}

-(BOOL)check {
        
    NSMutableArray *arrays = [[[NSMutableArray alloc] init] autorelease];
    
    NSMutableArray *row0 = (NSMutableArray *)[board.items objectAtIndex:0];
    NSMutableArray *row1 = (NSMutableArray *)[board.items objectAtIndex:1];
    NSMutableArray *row2 = (NSMutableArray *)[board.items objectAtIndex:2];
    
    NSMutableArray *col0 = [NSMutableArray arrayWithObjects:[row0 objectAtIndex:0], [row1 objectAtIndex:0],[row2 objectAtIndex:0], nil];
    NSMutableArray *col1 = [NSMutableArray arrayWithObjects:[row0 objectAtIndex:1], [row1 objectAtIndex:1],[row2 objectAtIndex:1], nil];
    NSMutableArray *col2 = [NSMutableArray arrayWithObjects:[row0 objectAtIndex:2], [row1 objectAtIndex:2],[row2 objectAtIndex:2], nil];
    
    NSMutableArray *dia1 = [NSMutableArray arrayWithObjects:[row0 objectAtIndex:0], [row1 objectAtIndex:1],[row2 objectAtIndex:2], nil];
    NSMutableArray *dia2 = [NSMutableArray arrayWithObjects:[row0 objectAtIndex:2], [row1 objectAtIndex:1],[row2 objectAtIndex:0], nil];
    
    [arrays addObjectsFromArray:[NSArray arrayWithObjects:row0, row1, row2, col0, col1, col2, dia1, dia2, nil]];
    
    for (NSMutableArray *arrayToCheck in arrays) {

        int crosses = 0;
        int noughts = 0;
        
        for (int i = 0; i<[arrayToCheck count]; i++) {
    
            Item *item = [arrayToCheck objectAtIndex:i];
            
            if ([item isKindOfClass:[NSNull class]]) {}
            else if (item.type == ItemTypeCross) crosses++;
            else if (item.type == ItemTypeNought) noughts++;
            
            if (crosses == 3 || noughts == 3) { 
            
                isOver = YES;
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)checkWithLocation:(CGPoint)location {
    BOOL success = [self check];
    
    if (success) {
        
        if ([delegate respondsToSelector:@selector(game:didFinishWithWinningItem:)]) {
            Item *item = [board itemForLocation:location];
            [delegate game:self didFinishWithWinningItem:item.type];
        }
    }
    else if (movesCount == kMovesLimit) {
        
        if ([delegate respondsToSelector:@selector(game:didFinishWithWinningItem:)]) {
            [delegate game:self didFinishWithWinningItem:ItemTypeUndefined];
        } 
        
    }
}

-(void)updateFieldAtLocation:(CGPoint)location {
    
    Item *item = [board itemForLocation:location];
    
    if (!item || [item isEqual:[NSNull null]]) {
        
        switch (itemTypeToMove) {
            case ItemTypeCross:
                [board insertItem:[Item itemWithType:ItemTypeNought] atLocation:location];
                itemTypeToMove = ItemTypeNought;
                break;
            case ItemTypeNought:
                [board insertItem:[Item itemWithType:ItemTypeCross] atLocation:location];
                itemTypeToMove = ItemTypeCross;
                break;  
            default:
                return;
        }
        
        if ([delegate respondsToSelector:@selector(game:didUpdateItemAtLocation:)]) {
            [delegate game:self didUpdateItemAtLocation:location];
        }
        
        movesCount++;
        if (movesCount == kMovesLimit) isOver = YES;
        
        [self checkWithLocation:location];
    }
}

-(void)dealloc {
    
    [board release];
    [super dealloc];
}
@end