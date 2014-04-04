//
//  SOSMainViewController.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-04.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSMainViewController.h"

@interface SOSMainViewController ()

@end

@implementation SOSMainViewController

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
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    NSString *username = [userDefaults stringForKey:@"username"];
    NSString *password = [userDefaults stringForKey:@"password"];
    if(username == nil || password == nil){
        [self performSegueWithIdentifier:@"loginSegue" sender:self.view];
    }
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

@end
