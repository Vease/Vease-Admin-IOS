//
//  VALeadPendingTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 29/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VALeadPendingTableViewCell : UITableViewCell
{
    
}

@property(strong,nonatomic)IBOutlet UILabel *lblname;
@property(strong,nonatomic)IBOutlet UILabel *lblPrice;
@property(strong,nonatomic)IBOutlet UIView *viewCellBack;
@property(strong,nonatomic)IBOutlet UILabel *lblTime;
@property(strong,nonatomic)IBOutlet UILabel *lblStatus;
@property(strong,nonatomic)IBOutlet UILabel *lblDate;
@property(strong,nonatomic)IBOutlet UILabel *lblService;

@end

NS_ASSUME_NONNULL_END
