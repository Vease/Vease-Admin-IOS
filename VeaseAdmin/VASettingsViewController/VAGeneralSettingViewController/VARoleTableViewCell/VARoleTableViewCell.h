//
//  VARoleTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VARoleTableViewCell : UITableViewCell
{
    
}

@property(strong,nonatomic)IBOutlet UILabel *lblName;
@property(strong,nonatomic)IBOutlet UILabel *lblStatus;
@property(strong,nonatomic)IBOutlet UIButton *btnEdit;
@property(strong,nonatomic)IBOutlet UIButton *btnDelete;

@end

NS_ASSUME_NONNULL_END
