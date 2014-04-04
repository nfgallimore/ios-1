//
//  SOSAppointment.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSAppointment.h"
#import "SOSUser.h"

@interface SOSAppointment ()

@property  NSString *coachid;
@property NSString *studentid;

@end

@implementation SOSAppointment

static NSMutableDictionary *_appointments;

+ (NSString *)statusStringFromNumber:(NSNumber *)statusInt
{
    return @{@0: @"Cancelled", @1: @"Completed", @2: @"Ongoing", @3: @"Confirmed", @4: @"Pending"}[statusInt];
}

+ (UIColor *)statusColorFromNumber:(NSNumber *)statusInt
{
    UIColor *green = [UIColor colorWithRed:0.298 green:0.545 blue:0.38 alpha:1]; /*#4c8b61*/
    UIColor *blue = [UIColor colorWithRed:0.169 green:0.482 blue:0.835 alpha:1]; /*#2b7bd5*/
    UIColor *red = [UIColor colorWithRed:0.682 green:0.067 blue:0.067 alpha:1]; /*#ae1111*/
    
    return @{@0: red, @1: green, @2: blue, @3: green, @4: blue}[statusInt];
}

+ (SOSAppointment *)appointmentWithDictionary:(NSDictionary *)appointment
{
    if (_appointments == nil) {
        _appointments = [[NSMutableDictionary alloc] init];
    }
    if ([_appointments objectForKey:[appointment objectForKey:@"id"]] == nil) {
        SOSAppointment *a = [[SOSAppointment alloc] initWithDictionary:appointment];
        _appointments[[appointment objectForKey:@"id"]] = a;
    }
    return [_appointments objectForKey:[appointment objectForKey:@"id"]];
}

- (id)initWithDictionary:(NSDictionary *)appointment
{
    self = [super init];
    
    if(self){
        self.studentid = appointment[@"studentid"];
        self.coachid = appointment[@"coachid"];
        
        self.identifier = appointment[@"id"];
        self.title = appointment[@"title"];
        self.status = appointment[@"status"];
        self.length = appointment[@"length"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.start = [dateFormatter dateFromString:appointment[@"start"]];
    }
    
    return self;
}

- (void)initUsers
{
    self.coach = [SOSUser userWithIdentifier:self.coachid];
    self.student = [SOSUser userWithIdentifier:self.studentid];
}
@end
