//
//  MasterViewController.h
//  NoughtsAndCrosses
//
//  Created by Rafal Sroka on 11-10-29.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
