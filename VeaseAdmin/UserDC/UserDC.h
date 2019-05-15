//
//  UserDC.h
//  HomeVisit
//
//  Created by MB Air on 23/05/2017.
//  Copyright © 2017 MB Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyDetailDC.h"

@interface UserDC : NSObject
{
    
}

@property(strong,nonatomic) NSString *application_fee;
@property(strong,nonatomic) NSString *company_stripe_account;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *token;
@property(strong,nonatomic) NSString *user_id;
@property(strong,nonatomic) NSString *is_login;

//Company Detail

@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *country;
@property(strong,nonatomic) NSString *created_at;
@property(strong,nonatomic) NSString *domain_name;
@property(strong,nonatomic) NSString *c_id;
@property(strong,nonatomic) NSString *image;
@property(strong,nonatomic) NSString *phone;
@property(strong,nonatomic) NSString *rand_id;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *time_zone;
@property(strong,nonatomic) NSString *updated_at;
@property(strong,nonatomic) NSString *user_name;


@end
 
