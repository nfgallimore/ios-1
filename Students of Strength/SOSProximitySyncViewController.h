//
//  SOSProximitySyncViewController.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-09.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SOSSyncSource.h"

@interface SOSProximitySyncViewController : UIViewController <SOSSyncSource ,CBPeripheralManagerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *outgoingBeaconRegion;
@property (strong, nonatomic) CLBeaconRegion *incomingBeaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property NSNumber *minor;

@end
