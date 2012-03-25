//
//  MultiAdView.m
//  MobclixDemo
//
//  Created by Tyler White on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiAdView.h"

@implementation MultiAdView

@synthesize delegate;
@synthesize mobclixAdView;
@synthesize iAdBannerView;

#define kAnimationDuration 0.15

#pragma mark - Orientation & Layout

- (void) adjustHeightForNewAdSize {
    
    CGSize newAdSize = CGSizeZero;
    if (!self.iAdBannerView.isHidden) { // If we are showing iAds, use the iAd size
        
        newAdSize = [ADBannerView sizeFromBannerContentSizeIdentifier:self.iAdBannerView.currentContentSizeIdentifier];
        
    } else if (!self.mobclixAdView.isHidden) { // If we are showing Mobclix, use the Mobclix size
        
        newAdSize = self.mobclixAdView.frame.size;
    }
  
    // Set this view's new height if necessary
    if (newAdSize.height != self.frame.size.height) {
        CGRect newRect = self.frame;
        newRect.size.height = newAdSize.height;
        [self setFrame:newRect];
        // Inform the delegate to shift views
        [self.delegate multiAdView:self wantsNewHeight:newRect.size.height];
    }
}


- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
    
    // Set the iAd Banner View to use the correct size ad for the current interface    
    NSString *size = ((orientation == UIInterfaceOrientationPortrait) || (orientation == UIInterfaceOrientationPortraitUpsideDown)) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierLandscape;
    [self.iAdBannerView setCurrentContentSizeIdentifier:size];

    // Adjust the view for the new iAd size if necessary
    [self adjustHeightForNewAdSize];
}

#pragma mark - Mobclix Delegate Methods

- (void)adViewDidFinishLoad:(MobclixAdView*)adView
{
    
    NSLog(@"Mobclix ad did load.");
    
    [adView setHidden:FALSE];

    // Adjust our view sizes if necessary.
    [self adjustHeightForNewAdSize];
}

#pragma mark - iAdBannerView Delegate Methods

- (void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    NSLog(@"iAd did load, pausing Mobclix.");
    
    // Make sure it's visible too.
    [self.iAdBannerView setHidden:FALSE];
    
    // Since iAds filled, let's pause Mobclix and move it out of the way.
    [self.mobclixAdView pauseAdAutoRefresh];
    [self.mobclixAdView setHidden:TRUE];
    
    // Adjust the view for the new iAd
    [self adjustHeightForNewAdSize];
}

- (void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    
    NSLog(@"iAd did fail load, starting Mobclix.");
    
    // Since iAds failed, let's get an ad from Mobclix.
    [self.mobclixAdView resumeAdAutoRefresh];
    [self.mobclixAdView setHidden:FALSE];
    
    // Hide the iAd View
    [self.iAdBannerView setHidden:TRUE];
}

#pragma mark - Initialization Method

- (id) initWithDelegate:(id<MultiAdViewDelegate>)theDelegate
{
    self = [super init];
    if (self) {
        
        self.delegate = theDelegate;
        self.backgroundColor = [UIColor underPageBackgroundColor];
        
        // Create the MobclixAdView based on the current device.        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            self.mobclixAdView = [[MobclixAdViewiPhone_320x50 alloc] init];
            
        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.mobclixAdView = [[MobclixAdViewiPad_728x90 alloc] init];
        }
        
        [self.mobclixAdView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
        [self.mobclixAdView setDelegate: self];
        [self.mobclixAdView setHidden:TRUE];
        [self addSubview:self.mobclixAdView];
        
        // Create the iAdBannerView
        self.iAdBannerView = [[ADBannerView alloc] init];        
        // Set the ad sizes (only use the orientation you are going to support!)
        NSSet *sizes = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
        [self.iAdBannerView setRequiredContentSizeIdentifiers:sizes];
        [self.iAdBannerView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
        [self.iAdBannerView setDelegate:self];
        [self.iAdBannerView setHidden:TRUE];
        [self addSubview:self.iAdBannerView];
    }
    return self;
}

- (void) dealloc
{
    
    // Apple docs say to set the delegate to nil.
    [self.iAdBannerView setDelegate:nil];
    
    // And this is how you properly stop a MobclixAdView.
    [self.mobclixAdView cancelAd];
    [self.mobclixAdView setDelegate:nil];
    [self setMobclixAdView:nil];
}

@end
