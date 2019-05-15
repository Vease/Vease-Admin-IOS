//
//  VANotificationTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VANotificationTableViewCell : UITableViewCell
{
    
}


@property(strong,nonatomic)IBOutlet UILabel *lblCompany;
@property(strong,nonatomic)IBOutlet UILabel *lblComments;
@property(strong,nonatomic)IBOutlet UILabel *lblStatus;
@property(strong,nonatomic)IBOutlet UIButton *btnTakeAction;
@end

NS_ASSUME_NONNULL_END
