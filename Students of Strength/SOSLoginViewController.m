//
//  SOSLoginViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-04.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSLoginViewController.h"
#import "SOSURLUtil.h"
#import <QuartzCore/QuartzCore.h>

@interface SOSLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property BOOL submitting;
@end

@implementation SOSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.submitting = NO;
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

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loginButtonDidClick:nil];
    return YES;
}

- (IBAction)loginButtonDidClick:(UIButton *)sender {
    
    if (self.submitting == YES) {
        return;
    }
    
    self.submitting = YES;
    [self.loginButton setEnabled:NO];
    
    self.emailField.layer.borderColor = [[UIColor blueColor] CGColor];
    self.emailField.layer.borderWidth = 1;
    self.passwordField.layer.borderColor = [[UIColor blueColor] CGColor];
    self.passwordField.layer.borderWidth = 1;
    
    if (self.emailField.text.length < 6) {
        self.emailField.layer.borderColor = [[UIColor redColor] CGColor];
    }
    if (self.passwordField.text.length < 6) {
        self.passwordField.layer.borderColor = [[UIColor redColor] CGColor];
    }
    if (self.emailField.text.length > 5 && self.passwordField.text.length > 5) {
        NSData *json = [NSData dataWithContentsOfURL:[SOSURLUtil URLForLoginWithUsername:self.emailField.text password:self.passwordField.text]];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
        if ([result[@"status"] isEqualToString:@"success"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:(NSString *)result[@"userid"] forKey:@"identifier"];
            [userDefaults synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if ([result[@"status"] isEqualToString:@"error"])
        {
            if ([result[@"field"] isEqualToString:@"email"]) {
                self.emailField.layer.borderColor = [[UIColor redColor] CGColor];
            }
            else if ([result[@"field"] isEqualToString:@"password"]) {
                self.passwordField.layer.borderColor = [[UIColor redColor] CGColor];
            }
        }
    }
    
    self.submitting = NO;
    [self.loginButton setEnabled:YES];
}
@end
