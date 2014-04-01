//
//  SOSCompletedTableViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSCompletedTableViewController.h"

#import "SOSAppointment.h"
#import "SOSAppointmentTableViewCell.h"

@interface SOSCompletedTableViewController ()

@property NSMutableArray *appointments;

@end

@implementation SOSCompletedTableViewController

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
    
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ym-sos-api.herokuapp.com/appointments/completed/52f1de0edabae0c78fe9c713.json?offset=240&start=1396152000&end=1399780800&_=1396327111392"]];
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    
    self.appointments = [[NSMutableArray alloc] init];
    for (NSDictionary *obj in items) {
        SOSAppointment *appt = [[SOSAppointment alloc] initWithDictionary:obj];
        [self.appointments addObject:appt];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appointments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOSAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SOSAppointmentCellPrototype" forIndexPath:indexPath];
    
    SOSAppointment *appt = [self.appointments objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = appt.title;
    cell.studentLabel.text = appt.student;
    cell.coachLabel.text = appt.coach;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", appt.start];
    cell.statusLabel.text = [SOSAppointment statusIntToString:appt.status];
    cell.statusLabel.textColor = [SOSAppointment statusIntToColor:appt.status];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
