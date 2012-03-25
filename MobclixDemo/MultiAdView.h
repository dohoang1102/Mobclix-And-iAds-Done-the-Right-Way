//
//  MultiAdView.h
//  MobclixDemo
//
//  Created by Tyler White on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobclixAdView.h"
#import "iAd/ADBannerView.h"

@protocol MultiAdViewDelegate;

@interface MultiAdView : UIView <MobclixAdViewDelegate, ADBannerViewDelegate>

// The view containing our Mobclix ads.
@property (strong, nonatomic) MobclixAdView *mobclixAdView;

// The view containing our iAds.
@property (strong, nonatomic) ADBannerView *iAdBannerView;

// We can send messages back to our delegate, in this case our MainViewController, to resize its views when ads come in.
@property (assign, nonatomic) id<MultiAdViewDelegate>delegate;

// Initialization method
- (id) initWithDelegate:(id<MultiAdViewDelegate>)theDelegate;

// So we can pass down orientation changes to switch iAd sizes
- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end

@protocol MultiAdViewDelegate <NSObject>

- (void) multiAdView:(MultiAdView *)multiAdView wantsNewHeight:(float)newHeight;

@end