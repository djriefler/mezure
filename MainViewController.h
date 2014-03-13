//
//  MainViewController.h
//  Mezure
//
//  Created by Duncan Riefler on 3/6/14.
//  Copyright (c) 2014 Duncan Riefler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MainViewController : UIViewController
{
    CMMotionManager * motionManager;
    NSString *filepath;
    double totalDisplacement;
    double prevAccel;
    double sumVelocity;
    int counter;
}
- (IBAction)startPressed:(id)sender;
- (IBAction)stopPressed:(id)sender;

- (void) updateAccelerometer;

@end
