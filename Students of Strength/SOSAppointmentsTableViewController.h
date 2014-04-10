//
//  SOSAppointmentsTableViewController.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOSSyncData.h"
#import "SOSGenericAppointmentsTableViewController.h"

@interface SOSAppointmentsTableViewController : UITableViewController <SOSSyncData>

@property NSDictionary *controllers;
@property NSNumber *selected;
@property (weak) SOSGenericAppointmentsTableViewController *current;

@end
