//
//  VALeadViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VALeadViewController : VAParentViewController<TYPagerViewDataSource, TYPagerViewDelegate,TYTabPagerBarDataSource,TYTabPagerBarDelegate,UITableViewDelegate,UITableViewDataSource,ServerDataHandlerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property(strong,nonatomic)IBOutlet UITableView *pendingTableView;
@property(strong,nonatomic)IBOutlet UITableView *completedTablView;

@end

NS_ASSUME_NONNULL_END
