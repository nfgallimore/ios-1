//
//  SOSUser.h
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSUser : NSObject

@property NSString *name;
@property NSString *cell;
@property NSString *email;
@property NSString *parentEmail;
@property NSString *skype;

+ (SOSUser *)userWithIdentifier:(NSString *)identifier;

@end
