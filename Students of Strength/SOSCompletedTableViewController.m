//
//  SOSCompletedTableViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSCompletedTableViewController.h"
#import "SOSURLUtil.h"

@interface SOSCompletedTableViewController ()

@end

@implementation SOSCompletedTableViewController

- (void)loadInitialValues
{
    [super loadInitialValues];
    self.dataSource = [SOSURLUtil URLForCompletedAppointmentsWithIdentifier:[[NSUserDefaults standardUserDefaults] stringForKey:@"identifier"]];
    self.cellPrototype = @"SOSCompletedCellPrototype";
}

@end
