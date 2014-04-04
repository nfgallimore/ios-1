//
//  SOSUser.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSUser.h"
#import "SOSURLUtil.h"

@implementation SOSUser

static NSMutableDictionary *_users;

+ (SOSUser *)userWithIdentifier:(NSString *)identifier
{
    if (_users == nil) {
        _users = [[NSMutableDictionary alloc] init];
    }
    if ([_users objectForKey:identifier] == nil) {
        NSLog(@"Fetching user %@",identifier);
        SOSUser *u = [[SOSUser alloc] initWithIdentifier:identifier];
       _users[identifier] = u;
    }
    return [_users objectForKey: identifier];
}

- (id)initWithDictionary:(NSDictionary *)user
{
    self = [super init];
    
    if(self){
        self.name = user[@"name"];
        self.cell = user[@"cell"];
        self.email = user[@"email"];
        self.parentEmail = user[@"parent_email"];
        self.skype = user[@"skype"];
    }
    
    return self;
}

- (id)initWithURL:(NSURL *)url
{
    NSData *json = [NSData dataWithContentsOfURL:url];
    NSDictionary *items = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    return [self initWithDictionary:items];
}

- (id)initWithIdentifier:(NSString *)identifier
{
    return [self initWithURL:[SOSURLUtil URLForUserWithIdentifier:identifier]];
}

@end
