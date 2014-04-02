//
//  SOSUser.m
//  Students of Strength
//
//  Created by Yasyf Mohamedali on 2014-04-01.
//  Copyright (c) 2014 Students of Strength. All rights reserved.
//

#import "SOSUser.h"

@implementation SOSUser

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

- (id)initWithUserId:(NSString *)userId
{
    return [self initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.studentsofstrength.com/user/%@.json",userId]]];
}

@end
