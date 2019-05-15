//
//  CompanyDetailDC.m
//  VeaseAdmin
//
//  Created by aliapple on 07/12/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "CompanyDetailDC.h"

@implementation CompanyDetailDC
@synthesize address,city,country,created_at,domain_name,c_id,image,phone,rand_id,state,time_zone,updated_at,user_name;

- (void)encodeWithCoder:(NSCoder *)coder{

    [coder encodeObject:address forKey:@"address"];
    [coder encodeObject:city forKey:@"city"];
    [coder encodeObject:country forKey:@"country"];
    [coder encodeObject:created_at forKey:@"created_at"];
    [coder encodeObject:domain_name forKey:@"domain_name"];
    [coder encodeObject:c_id forKey:@"c_id"];
    [coder encodeObject:image forKey:@"image"];
    [coder encodeObject:phone forKey:@"phone"];
    [coder encodeObject:rand_id forKey:@"rand_id"];
    [coder encodeObject:state forKey:@"state"];
    [coder encodeObject:time_zone forKey:@"time_zone"];
    [coder encodeObject:updated_at forKey:@"updated_at"];
    [coder encodeObject:user_name forKey:@"user_name"];
    
}

- (id)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self != nil)
    {
        address = [coder decodeObjectForKey:@"address"];
        city = [coder decodeObjectForKey:@"city"];
        country = [coder decodeObjectForKey:@"country"];
        created_at = [coder decodeObjectForKey:@"created_at"];
        domain_name = [coder decodeObjectForKey:@"domain_name"];
        c_id = [coder decodeObjectForKey:@"c_id"];
        image = [coder decodeObjectForKey:@"image"];
        phone = [coder decodeObjectForKey:@"phone"];
        rand_id = [coder decodeObjectForKey:@"rand_id"];
        state = [coder decodeObjectForKey:@"state"];
        time_zone = [coder decodeObjectForKey:@"time_zone"];
        updated_at = [coder decodeObjectForKey:@"updated_at"];
        user_name = [coder decodeObjectForKey:@"user_name"];
    }
    return self;
}

@end
