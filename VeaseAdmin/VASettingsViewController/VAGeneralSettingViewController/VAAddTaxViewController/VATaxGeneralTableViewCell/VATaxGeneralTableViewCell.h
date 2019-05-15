//
//  VATaxGeneralTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VATaxGeneralTableViewCell : UITableViewCell
{
    
}

@property(strong,nonatomic)IBOutlet UILabel *lblname;
@property(strong,nonatomic)IBOutlet UILabel *lblPercentage;
@property(strong,nonatomic)IBOutlet UILabel *lblJurisdication;
@property(strong,nonatomic)IBOutlet UISwitch *taxSwitch;


@end

NS_ASSUME_NONNULL_END
