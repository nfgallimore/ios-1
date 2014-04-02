//
//  SOSCompletedTableViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSCompletedTableViewController.h"

@interface SOSCompletedTableViewController ()

@end

@implementation SOSCompletedTableViewController

- (void)loadInitialValues
{
    [super loadInitialValues];
    self.dataSource = [NSURL URLWithString:@"http://ym-sos-api.herokuapp.com/appointments/completed/52f1de0edabae0c78fe9c713.json?offset=240&start=1396152000&end=1399780800&_=1396327111392"];
    self.cellPrototype = @"SOSCompletedCellPrototype";
}

@end
