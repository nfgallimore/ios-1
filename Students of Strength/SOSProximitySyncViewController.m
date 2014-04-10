//
//  SOSProximitySyncViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-09.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSProximitySyncViewController.h"
#import "SOSAppointmentsTableViewController.h"
#import "SOSGenericAppointmentsTableViewController.h"
#import "SOSSyncData.h"

@interface SOSProximitySyncViewController ()

@end

@implementation SOSProximitySyncViewController

static NSString *UUIDString = @"134E8A56-FA01-4B75-AB33-FCAECE4BE90C";
static NSString *UUIDIdentifier = @"com.studentsofstrength.proximitysync";


- (void)initReceiver
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:UUIDString];
    self.incomingBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:UUIDIdentifier];
    
}

- (void)turnOnReceiver
{
    [self.locationManager startMonitoringForRegion:self.incomingBeaconRegion];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.incomingBeaconRegion];
}

- (void)initBeacon
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:UUIDString];
    SOSAppointmentsTableViewController<SOSSyncData> *appointments = [[[self tabBarController] viewControllers][0] viewControllers][0];
    SOSGenericAppointmentsTableViewController<SOSSyncData> *current = appointments.current;
    self.outgoingBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:(int)appointments.selected minor:(int)current.selected identifier:UUIDIdentifier];
}

- (void)turnOnBeacon
{
    self.beaconPeripheralData = [self.outgoingBeaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (void)turnOffBeacons
{
    [self.peripheralManager stopAdvertising];
    [self.locationManager stopRangingBeaconsInRegion:self.incomingBeaconRegion];
    [self.locationManager stopMonitoringForRegion:self.incomingBeaconRegion];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Beacon Now On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        NSLog(@"Beacon Now Off");
        [self.peripheralManager stopAdvertising];
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *beacon = [beacons lastObject];
    if (beacon != nil && [self.minor isEqual: @-1]) {
        //NSLog(@"%@",beacon);
        if (beacon.proximity == CLProximityImmediate) {
            self.minor = beacon.minor;
            [self turnOffBeacons];
            SOSAppointmentsTableViewController *appointments = [[[self tabBarController] viewControllers][0] viewControllers][0];
            NSString *segueIdentifier = [appointments.controllers allValues][[beacon.major intValue]];
            [appointments performSegueWithIdentifier:segueIdentifier sender:self];
            [[self tabBarController] setSelectedIndex:0];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [self.locationManager startRangingBeaconsInRegion:self.incomingBeaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.incomingBeaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.incomingBeaconRegion];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.minor = @-1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.minor = @-1;
    [self initBeacon];
    [self initReceiver];
    [self turnOnBeacon];
    [self turnOnReceiver];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self turnOffBeacons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
