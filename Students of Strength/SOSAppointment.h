//
//  SOSAppointment.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOSUser.h"

@interface SOSAppointment : NSObject

@property NSString *identifier;
@property NSString *title;
@property SOSUser *coach;
@property SOSUser *student;
@property NSDate *start;
@property NSNumber *status;
@property NSNumber *length;

+ (NSString *)statusStringFromNumber:(NSNumber *)statusInt;
+ (UIColor *)statusColorFromNumber:(NSNumber *)statusInt;

+ (SOSAppointment *)appointmentWithDictionary:(NSDictionary *)appointment;
- (void)initUsers;
@end

