//
//  SOSAppointmentViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSAppointmentViewController.h"

#import "SOSAppointment.h"

@interface SOSAppointmentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *studentButton;
@property (weak, nonatomic) IBOutlet UIButton *coachButton;
@property (weak) SOSUser *currentUser;

@end

@implementation SOSAppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom init
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.appointment.coach == nil || self.appointment.student == nil){
        [self.appointment initUsers];
    }
    
    self.titleLabel.text = self.appointment.title;
    [self.studentButton setTitle:[NSString stringWithFormat:@"Student: %@",self.appointment.student.name] forState:UIControlStateNormal];
    [self.coachButton setTitle:[NSString stringWithFormat:@"Coach: %@",self.appointment.coach.name] forState:UIControlStateNormal];
    self.statusLabel.text = [SOSAppointment statusStringFromNumber:self.appointment.status];
    self.statusLabel.textColor = [SOSAppointment statusColorFromNumber:self.appointment.status];
    self.lengthLabel.text = [NSString stringWithFormat:@"%@ Minutes",self.appointment.length];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.appointment.start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)contactMethodsWithUser:(SOSUser *)user
{
    NSMutableArray *methods = [NSMutableArray array];
    if(user.cell.length > 0){
        [methods addObject:@"Call"];
    }
    if(user.skype.length > 0){
        [methods addObject:@"Skype"];
    }
    if(user.email.length > 0){
        [methods addObject:@"Email"];
    }
    if(user.parentEmail.length > 0){
        [methods addObject:@"Email Parent"];
    }
    return [methods copy];
    
}

- (void)showActionSheetWithTitle:(NSString *)title
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (NSString *method in [self contactMethodsWithUser:self.currentUser]) {
        [actionSheet addButtonWithTitle:method];
    }
    
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:[actionSheet numberOfButtons]-1];
    
    [actionSheet showInView:self.view];
}

- (IBAction)studentButtonClick:(id)sender {
    
    self.currentUser = self.appointment.student;
    [self showActionSheetWithTitle:[NSString stringWithFormat:@"Contact %@",self.appointment.student.name]];
    
}

- (IBAction)coachButtonClick:(id)sender {
    self.currentUser = self.appointment.coach;
    [self showActionSheetWithTitle:[NSString stringWithFormat:@"Contact %@",self.appointment.coach.name]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Call"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.currentUser.cell]]];
    }
    else if ([buttonTitle isEqualToString:@"Email"]){
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setToRecipients:[[NSArray alloc] initWithObjects:self.currentUser.email, nil]];
        [self presentViewController:mailViewController animated:YES completion:NULL];
    }
    else if ([buttonTitle isEqualToString:@"Email Parent"]){
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setToRecipients:[[NSArray alloc] initWithObjects:self.currentUser.parentEmail, nil]];
        [self presentViewController:mailViewController animated:YES completion:NULL];
    }
    else if ([buttonTitle isEqualToString:@"Skype"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"skype:%@",self.currentUser.skype]]];
    }
    else
    {
        //NSLog(@"%@",buttonTitle);
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            //NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
