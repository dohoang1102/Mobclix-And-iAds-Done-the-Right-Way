//
//  MainViewController.m
//  MobclixDemo
//
//  Created by Tyler White on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize tableViewData;
@synthesize tableView;
@synthesize multiAdView;

#define kAnimationDuration 0.15

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        // Init our MultiAdView
        self.multiAdView = [[MultiAdView  alloc] initWithDelegate:self];
        
        // Init our tableView
        self.tableView = [[UITableView alloc] init];
        
        // Build the tableView data source
        self.tableViewData = [[NSArray alloc] initWithObjects: // Thank you http://en.wikipedia.org/wiki/List_of_animal_names
                              @"Aardvark",
                              @"Albatross",
                              @"Alligator",
                              @"Alpaca",
                              @"American Bison",
                              @"Ant",
                              @"Anteater",
                              @"Antelope",
                              @"Ape",
                              @"Armadillo",
                              @"Ass/Donkey",
                              @"Baboon",
                              @"Badger",
                              @"Barracuda",
                              @"Bat",
                              @"Bear",
                              @"Beaver",
                              @"Bee",
                              @"Bison",
                              @"Boar",
                              @"Buffalo",
                              @"Bush baby",
                              @"Butterfly",
                              @"Camel",
                              @"Caribou",
                              @"Cat",
                              @"Caterpillar",
                              @"Cattle",
                              @"Chamois",
                              @"Cheetah",
                              @"Chicken",
                              @"Chimpanzee",
                              @"Chinchilla",
                              @"Clam",
                              @"Cobra",
                              @"Cockroach",
                              @"Cod",
                              @"Cormorant",
                              @"Coyote",
                              @"Crab",
                              @"Crane",
                              @"Crocodile",
                              @"Crow",
                              nil];

    }
    return self;
}

#pragma mark - Layout Our Two Views

// UIKit's springs and struts for autorisizing subviews gets us most of the way when the orientation changes.
// We use this layout subviews methods to get it just right.
- (void) layoutSubviews {
    
    CGSize appSize = [UIApplication currentSize];
    
    // Adjust our table view
    CGRect tv = CGRectMake(0, 0, [UIApplication currentSize].width, [UIApplication currentSize].height);
    tv.size.height = appSize.height - self.multiAdView.frame.size.height;
    [self.tableView setFrame:tv];
    
    // Adjust our multi ad view
    [self.multiAdView setFrame:CGRectMake(0, self.tableView.frame.size.height, [UIApplication currentSize].width, self.multiAdView.frame.size.height)];
}

#pragma mark - MultiAdViewDelegate Methods

- (void) multiAdView:(MultiAdView *)theMultiAdView wantsNewHeight:(float)newHeight {
    
    // Animate the views into their new sizes
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                         
                         // Adjust MultiAdView
                         CGRect newRect = CGRectMake(theMultiAdView.frame.origin.x, theMultiAdView.frame.origin.y, multiAdView.frame.size.width, newHeight);
                         [theMultiAdView setFrame:newRect];
                         
                         [self layoutSubviews];
                     }];
}

#pragma mark - View Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure our tableView
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight];
    [self.tableView setFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    // Configure our MultiAdView
    [self.multiAdView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:self.multiAdView];
    
    // Layout the views
    [self layoutSubviews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return TRUE;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{ 
    // Refresh our view heights when the orientation changes as UIKit's springs & struts are not enough
    [self layoutSubviews];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration 
{
    // Inform our MultiAdView
    [self.multiAdView willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[self.tableViewData objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
