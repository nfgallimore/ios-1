//
//  SOSGenericAppointmentsTableViewController.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOSSyncSource.h"
#import "SOSSyncData.h"

@interface SOSGenericAppointmentsTableViewController : UITableViewController <SOSSyncSource, SOSSyncData>

- (void)loadInitialValues;

@property NSURL *dataSource;
@property NSString *cellPrototype;
@property NSNumber *minor;
@property NSNumber *selected;

@end
