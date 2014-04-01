//
//  SOSAppointment.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSAppointment.h"

@implementation SOSAppointment

+ (NSString *)statusIntToString:(NSNumber *)statusInt
{
    return @{@0: @"Cancelled", @1: @"Completed", @2: @"Ongoing", @3: @"Confirmed", @4: @"Pending"}[statusInt];
}

+ (UIColor *)statusIntToColor:(NSNumber *)statusInt
{
    UIColor *green = [UIColor greenColor];
    UIColor *blue = [UIColor blueColor];
    UIColor *red = [UIColor redColor];
    
    return @{@0: red, @1: green, @2: blue, @3: green, @4: blue}[statusInt];
}

- (id)initWithDictionary:(NSDictionary *)appointment
{
    self = [super init];
    
    if(self){
        self.title = appointment[@"title"];
        self.coach = appointment[@"coach"];
        self.student = appointment[@"student"];
        self.status = appointment[@"status"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.start = [dateFormatter dateFromString:appointment[@"start"]];
    }
    
    return self;
}
@end
