//
//  SOSAppointment.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSAppointment : NSObject

@property NSString *title;
//TODO: Model People
@property NSString *coach;
//TODO: Model People
@property NSString *student;
@property NSDate *start;
@property NSNumber *status;

+ (NSString *)statusIntToString:(NSNumber *)statusInt;
+ (UIColor *)statusIntToColor:(NSNumber *)statusInt;

- (id)initWithDictionary:(NSDictionary *)appointment;
@end
