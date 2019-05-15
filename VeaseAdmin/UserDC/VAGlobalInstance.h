//
//  VAGlobalInstance.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDC.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAGlobalInstance : NSObject


+(VAGlobalInstance *)getInstance;

- (void)saveCustomObject:(UserDC *)object key:(NSString *)key;

- (UserDC *)loadCustomObjectWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
