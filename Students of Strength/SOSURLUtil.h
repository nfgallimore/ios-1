//
//  SOSURLUtil.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-04.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSURLUtil : NSObject

+ (NSString *)escapeURIComponent:(NSString *)component;

+ (NSURL *)URLForLoginWithUsername:(NSString *)username password:(NSString *)password;
+ (NSURL *)URLForUserWithIdentifier:(NSString *)identifier;
+ (NSURL *)URLForCompletedAppointmentsWithIdentifier:identifier;
+ (NSURL *)URLForUpcomingAppointmentsWithIdentifier:identifier;

@end
