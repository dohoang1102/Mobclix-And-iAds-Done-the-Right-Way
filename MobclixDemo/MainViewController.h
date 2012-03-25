//
//  MainViewController.h
//  MobclixDemo
//
//  Created by Tyler White on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiAdView.h"
#import "UIApplication+AppDimensions.h"

// Note: We're using a UIViewController instead of a UITableViewController so that we can handle the tableView and the MultiAdView seperately.
@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MultiAdViewDelegate>

// An array holding the names of some animals for our table view.
@property (strong, nonatomic) NSArray *tableViewData;

// The table view.
@property (strong, nonatomic) UITableView *tableView;

// Our special ad view that keeps all ads separate from our main app.
@property (strong, nonatomic) MultiAdView *multiAdView;

@end