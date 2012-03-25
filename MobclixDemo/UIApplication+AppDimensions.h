//
//  UIApplication+AppDimensions.h
//  MobclixDemo
//
//  Created by Tyler White on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Thanks http://stackoverflow.com/questions/7905432/how-to-get-orientation-dependent-height-and-width-of-the-screen

#import <Foundation/Foundation.h>

@interface UIApplication(AppDimensions)
+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;
@end