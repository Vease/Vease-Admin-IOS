//
//  VASettingsViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASettingsViewController : VAParentViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property(strong,nonatomic)IBOutlet UITableView *menuTableView;

@end

NS_ASSUME_NONNULL_END
