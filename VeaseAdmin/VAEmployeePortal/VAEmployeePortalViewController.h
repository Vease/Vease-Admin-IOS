//
//  VAEmployeePortalViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 15/04/2019.
//  Copyright © 2019 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAEmployeePortalViewController : VAParentViewController <UITableViewDelegate,UITableViewDataSource>
{
    
}

@property(strong,nonatomic)IBOutlet UITableView *menuTableView;

@end

NS_ASSUME_NONNULL_END
