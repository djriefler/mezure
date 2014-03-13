//
//  MainViewController.m
//  Mezure
//
//  Created by Duncan Riefler on 3/6/14.
//  Copyright (c) 2014 Duncan Riefler. All rights reserved.
//

#import "MainViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        motionManager = [[CMMotionManager alloc] init];
        filepath = [[NSString alloc] init];
        counter = 0;
        totalDisplacement = 0;
    }
    return self;
}

- (IBAction)startPressed:(id)sender {
    [self updateAccelerometer];
}

- (IBAction)stopPressed:(id)sender {
    [motionManager stopAccelerometerUpdates];
}

- (void) updateAccelerometer
{
    NSTimeInterval updateInterval = .01;
    
    [motionManager setAccelerometerUpdateInterval:updateInterval];
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
    {

        // print accelerometer data
        if (counter > 1) {
            double currentAccel = [self truncatedValue:accelerometerData.acceleration.x];
            double avgAccel = (currentAccel + prevAccel)/2;
            double currentVelocity = updateInterval * avgAccel;
            double avgVelocity = (currentVelocity + sumVelocity)/2;
            double displacement = avgVelocity * updateInterval;
            totalDisplacement += displacement;
            sumVelocity += currentVelocity;
            prevAccel = currentAccel;
        }
        else if (counter > 0) {
            double currentAccel = [self truncatedValue:accelerometerData.acceleration.x];
            double avgAccel = (currentAccel + prevAccel)/2;
            prevAccel = currentAccel;
            sumVelocity = updateInterval * avgAccel;
        }
        else {
            prevAccel = [self truncatedValue:accelerometerData.acceleration.x];
        }
        NSLog(@"%f",accelerometerData.acceleration.x);
//        NSLog(@"%f",totalDisplacement);
        counter++;
    }];
}

- (double) truncatedValue: (double) original
{
    int tmp = original * 100000; // 44.8 truncated to 44
    float truncated = tmp / 100000.0; // 4.4
    return truncated;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
