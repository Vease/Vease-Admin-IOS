//
//  VATaxesViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VATaxesViewController : VAParentViewController<ServerDataHandlerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    ServerDataHandler *objServerDataHandler;
}

@end

NS_ASSUME_NONNULL_END