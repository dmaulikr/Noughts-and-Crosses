//
//  Board.m
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

#import "Board.h"

@implementation Board
@synthesize width, height, items;

-(void)initItems {
    
    if (!items) {
        items = [[NSMutableArray alloc] initWithCapacity:height];
        
        for (int i=0; i<height; i++) {
        
            NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:width];
            
            for (int j=0; j<width; j++) [row addObject:[NSNull null]];
            
            [items addObject:row];
            [row release];
        }
    }
}

-(id)initWithSize:(CGSize )size {

    self = [super init];
    if (self) {
        width = size.width;
        height = size.height;
        
        [self initItems];
    }
    return self;
}

-(void)insertItem:(Item *)item atLocation:(CGPoint)location {
    
    NSMutableArray *row = [items objectAtIndex:location.y];
    [row replaceObjectAtIndex:location.x withObject:item];
}

-(Item *)itemForLocation:(CGPoint)location {
    
    NSMutableArray *rowArray = [items objectAtIndex:location.y];
    Item *item = [rowArray objectAtIndex:location.x];
    
    return item;
}

-(void)dealloc {
    [items retain];
    [super dealloc];
}

@end