//
//  VASTAFFTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASTAFFTableViewCell : UITableViewCell
{
    
}

@property(strong,nonatomic)IBOutlet UIImageView *imgView;
@property(strong,nonatomic)IBOutlet UILabel *lblName;
@property(strong,nonatomic)IBOutlet UILabel *lblEmail;
@property(strong,nonatomic)IBOutlet UILabel *lblDateTime;
@property(strong,nonatomic)IBOutlet UILabel *lblStatus;
@property(strong,nonatomic)IBOutlet UISwitch *statusSwitch;

@end

NS_ASSUME_NONNULL_END
