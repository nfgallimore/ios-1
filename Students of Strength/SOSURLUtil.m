//
//  SOSURLUtil.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-04.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSURLUtil.h"

@implementation SOSURLUtil

static const NSString *endpoint = @"https://api.studentsofstrength.com";

+ (NSString *)escapeURIComponent:(NSString *)component
{
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]\" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [component stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

+ (NSURL *)URLForLoginWithUsername:(NSString *)username password:(NSString *)password
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/auth/login.json?email=%@&password=%@", endpoint, [SOSURLUtil escapeURIComponent:username], [SOSURLUtil escapeURIComponent:password]]];
}

+ (NSURL *)URLForUserWithIdentifier:(NSString *)identifier
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/%@.json", endpoint, [SOSURLUtil escapeURIComponent:identifier]]];
}

+ (NSURL *)URLForCompletedAppointmentsWithIdentifier:identifier
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/appointments/completed/%@.json", endpoint, [SOSURLUtil escapeURIComponent:identifier]]];
}

+ (NSURL *)URLForUpcomingAppointmentsWithIdentifier:identifier
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/appointments/upcoming/%@.json", endpoint, [SOSURLUtil escapeURIComponent:identifier]]];
}

@end
