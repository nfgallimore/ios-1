//
//  SOSAppointmentsTableViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSAppointmentsTableViewController.h"
#import "SOSSyncSource.h"
#import "SOSGenericAppointmentsTableViewController.h"

@interface SOSAppointmentsTableViewController ()

@end

@implementation SOSAppointmentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.controllers == nil){
        self.controllers = @{@"Completed": @"completedSegue", @"Upcoming": @"upcomingSegue"};
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SOSAppointmentCellPrototype" forIndexPath:indexPath];
    
    NSString *controller = [[self.controllers allKeys] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = controller;
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SOSGenericAppointmentsTableViewController *destination = segue.destinationViewController;
    self.current = destination;
    if ([sender respondsToSelector:@selector(minor)]) {
        id<SOSSyncSource> source = sender;
        destination.minor = source.minor;
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [[self.controllers allValues] objectAtIndex:indexPath.row];
    self.selected = [NSNumber numberWithLong:indexPath.row];
    if(identifier){
        [self performSegueWithIdentifier:identifier sender:self.view];
    }
}

@end
