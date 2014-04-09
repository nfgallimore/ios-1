//
//  SOSUpcomingTableViewViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-09.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSUpcomingTableViewViewController.h"
#import "SOSURLUtil.h"

@interface SOSUpcomingTableViewViewController ()

@end

@implementation SOSUpcomingTableViewViewController

- (void)loadInitialValues
{
    [super loadInitialValues];
    self.dataSource = [SOSURLUtil URLForUpcomingAppointmentsWithIdentifier:[[NSUserDefaults standardUserDefaults] stringForKey:@"identifier"]];
    self.cellPrototype = @"SOSUpcomingCellPrototype";
}


@end
