//
//  ServerDataHandler.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "ServerDataHandler.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation ServerDataHandler

-(BOOL)userLogin:(NSString *)email password:(NSString *)password{
    NSString *queryurl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseUserLogin];
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"email": email,
                             @"password":password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    NSString *string = [[NSString alloc] initWithData:[jsonData mutableCopy] encoding:NSUTF8StringEncoding];
    NSLog(@"Request JSON: %@", string);
    
    [manager POST:queryurl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"Type",responseObject,@"responceData", nil]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        [self.delegate serverDidFail:error];
        
    }];
    
    return YES;
}

-(BOOL)registerCompany:(NSString *)name email:(NSString *)email password:(NSString *)password c_password:(NSString *)c_password{
    
    NSString *queryurl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseCompanyRegister];
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"name": name,
                             @"email":email,
                             @"password":password,
                             @"c_password":c_password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    NSString *string = [[NSString alloc] initWithData:[jsonData mutableCopy] encoding:NSUTF8StringEncoding];
    NSLog(@"Request JSON: %@", string);
    
    [manager POST:queryurl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"Type",responseObject,@"responceData", nil]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        [self.delegate serverDidFail:error];
        
    }];
    
    return YES;
}

-(BOOL)leadPage{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseLeadPage,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
               dispatch_async(dispatch_get_main_queue(), ^{
                   NSLog(@"Error: %@", error);
                   [self.delegate serverDidFail:error];
               });
             
          }
          
      }] resume];
    
    return YES;
    
}

-(BOOL)resolutionCenter{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseResolutionCenter,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"4", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)rescheduleReques{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseRescheduleRequest,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"5", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)requestAllServices{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseRequestAllServices];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"6", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)companyStaff{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseCompanyStaff,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"7", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)companyTaxList{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseCompanyTaxList,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"8", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getStaffRoles{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseStaffRoles];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"9", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getBundles{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseGetBundles];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"10", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)addBundles:(NSString *)name description:(NSString *)description{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    NSString *queryurl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseGetBundles];
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"name": name,
                             @"description":description};
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:queryurl]];
    [request setHTTPBody:postData];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"11", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getServicesById{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseGetServicesById,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"12", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)addShift:(NSString *)name unpaid_break:(NSString *)unpaid_break schedule_id:(NSString *)schedule_id to:(NSString *)to from:(NSString *)from notes:(NSString *)notes position:(NSString *)position{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseAddShift,objUserDc.user_id];
    ///format/json
    NSLog(@"Query %@",targetUrl);
    NSDictionary *params = @{@"name": name,
                             @"unpaid_break":unpaid_break,
                             @"schedule_id":schedule_id,
                             @"to":to,
                             @"from":from,
                             @"notes":notes,
                             @"position":position
                             };
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    [request setHTTPBody:postData];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"13", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getShifts{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseGetShifts,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"14", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)GetCompanyLocation{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseGetCompanyLocation];//,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"15", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)GetCompanySchedule{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseGetCompanySchedule,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"16", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)createSchedule:(NSString *)name address:(NSString *)address location_id:(NSString *)location_id to:(NSString *)to from:(NSString *)from day:(NSString *)day ip_address:(NSString *)ip_address hours:(NSString *)hours{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    NSString *queryurl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseCreateSchedule,objUserDc.user_id];
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"name": name,
                             @"address":address,
                             @"location_id":location_id,
                             @"to":to,
                             @"from":from,
                             @"day":day,
                             @"ip_address":ip_address,
                             @"hours":hours
                             };
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:queryurl]];
    [request setHTTPBody:postData];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"17", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getCompanyLocationList{
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseGetCompanyLocationList,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"18", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)createCompanyTax:(NSString *)name percentage:(NSString *)percentage jurisdiction:(NSString *)jurisdiction description:(NSString *)description dumpy_input:(NSString *)dumpy_input{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    NSString *queryurl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseCreateCompanyTax,objUserDc.user_id];
    
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"name": name,
                             @"Percentage":percentage,
                             @"jurisdiction":jurisdiction,
                             @"description":description,
                             @"dumpy_input":dumpy_input
                             };
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:queryurl]];
    [request setHTTPBody:postData];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"19", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getServices{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseGetServices];//,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"20", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
    
}

-(BOOL)addNewServices:(NSString *)name details:(NSString *)details category_id:(NSString *)category_id subcategory_id:(NSString *)subcategory_id price:(NSString *)price publish:(NSString *)publish status:(NSString *)status frequency:(NSString *)frequency currency:(NSString *)currency video_links:(NSString *)video_links company_id:(NSString *)company_id company_location_id:(NSString *)company_location_id{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    NSString *queryurl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseAddNewServices];//,objUserDc.user_id];
    
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"name": name,
                             @"details":details,
                             @"category_id":category_id,
                             @"subcategory_id":subcategory_id,
                             @"price":price,
                             @"publish":publish,
                             @"status":status,
                             @"frequency":frequency,
                             @"currency":currency,
                             @"video_links":video_links,
                             @"company_id":company_id,
                             @"company_location_id":company_location_id
                             };
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:queryurl]];
    [request setHTTPBody:postData];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"21", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
    
}

-(BOOL)getCategoryList{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@",kBaseMainURL,kBaseCategoryList];//,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"22", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)getSubCategory:(NSString *)category_id{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseGetSubCategory,category_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"23", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)deleteStaffRoles:(NSString *)role_id{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseDeleteStaffRoles,role_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"24", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
}

-(BOOL)GetCompanyDetail{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    // making a GET request.
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseGetCompanyDetail,objUserDc.user_id];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"25", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    
    return YES;
    
}

-(BOOL)UpdateCompanyProfile:(NSString *)name state:(NSString *)state time_zone:(NSString *)time_zone city:(NSString *)city domain_name:(NSString *)domain_name address:(NSString *)address phone:(NSString *)phone country:(NSString *)country image:(NSString *)image{
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    NSString *queryurl = [NSString stringWithFormat:@"%@%@/%@",kBaseMainURL,kBaseUpdateCompanyProfile,objUserDc.user_id];
    
    ///format/json
    NSLog(@"Query %@",queryurl);
    NSDictionary *params = @{@"name": name,
                             @"state":state,
                             @"time_zone":time_zone,
                             @"city":city,
                             @"domain_name":domain_name,
                             @"address":address,
                             @"phone":phone,
                             @"country":country//,
                            // @"image":image
                             };
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",objUserDc.token] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:queryurl]];
    [request setHTTPBody:postData];
    
    [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:[NSData dataWithContentsOfFile:image] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error){
            NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Data received: %@", myString);
            NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"26", @"Type",json,@"responceData", nil]];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Error: %@", error);
                [self.delegate serverDidFail:error];
            });
            
        }
        
    }];
    
    
    
    
    
   /* [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
 
          if(!error){
              NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", myString);
              NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
              id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate serverDidLoadDataSuccessfully: [NSDictionary dictionaryWithObjectsAndKeys:@"26", @"Type",json,@"responceData", nil]];
              });
          }
          else
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"Error: %@", error);
                  [self.delegate serverDidFail:error];
              });
              
          }
          
      }] resume];
    */
    return YES;
}

@end

