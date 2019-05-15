//
//  VAServicesTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAServicesTableViewCell : UITableViewCell
{
    
}

@property(strong,nonatomic)IBOutlet UILabel *lblCategoryName;
@property(strong,nonatomic)IBOutlet UILabel *lblSubCategory;
@property(strong,nonatomic)IBOutlet UILabel *lblDetail;
@property(strong,nonatomic)IBOutlet UISwitch *publishSwitch;
@property(strong,nonatomic)IBOutlet UILabel *lblPrice;

@end

NS_ASSUME_NONNULL_END
