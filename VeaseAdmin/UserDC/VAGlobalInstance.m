//
//  VAGlobalInstance.m
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAGlobalInstance.h"

@implementation VAGlobalInstance

static VAGlobalInstance *instance = nil;

+(VAGlobalInstance *)getInstance{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [VAGlobalInstance new];
            
        }
    }
    return instance;
}

- (void)saveCustomObject:(UserDC *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

- (UserDC *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    UserDC *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}


@end
