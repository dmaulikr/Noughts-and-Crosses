//
//  Item.h
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

/**
 Type of the item. Item can be of Cross, Nought or Undefined type.
 */
typedef enum {
    ItemTypeUndefined,
    ItemTypeNought,
    ItemTypeCross
} ItemType;

/**
 Class to represent an item - Cross or Nought in Noughts and Crosses.  
 */
@interface Item : NSObject {
    /**
     Type of the item.
     */
    ItemType type;
}
@property (nonatomic, assign) ItemType type;

/**
 Initialize a new item with desired type.
 @param type the type of the item. Cross, Nought or Undefined.
 @returns a newly initialized item.
 */
-(id)initWithType:(ItemType) itemType;

/**
 Initialize an autoreleased item with desired type.
 @param type the type of the item. Cross, Nought or Undefined.
 @returns a newly initialized autoreleased item.
 */
+(Item *)itemWithType:(ItemType) itemType;

/**
 Check whether two items have same type.
 @param item the item that will be checked.
 @returns YES if items have the same type. NO if they types are different.
 */
-(BOOL)isSameTypeAs:(Item *)item;
@end
