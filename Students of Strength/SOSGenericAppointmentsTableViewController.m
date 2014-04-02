//
//  SOSGenericAppointmentsTableViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSGenericAppointmentsTableViewController.h"

#import "SOSAppointment.h"
#import "SOSAppointmentViewController.h"

@interface SOSGenericAppointmentsTableViewController ()

@property NSMutableDictionary *appointments;
@property NSArray *sections;

@end

@implementation SOSGenericAppointmentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadInitialValues
{
    if (self.appointments == nil){
        self.appointments = [[NSMutableDictionary alloc] init];
    }
    if (self.sections == nil) {
        self.sections = [NSArray array];
    }
}

+ (NSDate *)dayForDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

- (void)fetch
{
    NSData *json = [NSData dataWithContentsOfURL:self.dataSource];
    NSArray *items = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *obj in items) {
        SOSAppointment *appt = [[SOSAppointment alloc] initWithDictionary:obj];
        NSDate *date = [SOSGenericAppointmentsTableViewController dayForDate:appt.start];
        if(self.appointments[date] == nil){
            self.appointments[date] = [NSMutableDictionary dictionary];
        }
        if ([self.appointments[date] objectForKey:appt.identifier] == nil) {
            self.appointments[date][appt.identifier] = appt;
        }
    }
    
    self.sections = [[[[self.appointments allKeys] sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadInitialValues];
    
    [self fetch];
    
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
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appointments[[self.sections objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *date = [self.sections objectAtIndex:section];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [dateFormatter stringFromDate:date];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellPrototype forIndexPath:indexPath];
    
    NSDate *date = self.sections[indexPath.section];
    
    SOSAppointment *appt = [[self.appointments[date] allValues] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = appt.title;
    cell.detailTextLabel.text = [SOSAppointment statusStringFromNumber:appt.status];
    return cell;
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     NSDate *date = self.sections[indexPath.section];
     SOSAppointmentViewController *destination = [segue destinationViewController];
     SOSAppointment *appointment = [[self.appointments[date] allValues] objectAtIndex:indexPath.row];
     destination.appointment = appointment;
 }


@end
