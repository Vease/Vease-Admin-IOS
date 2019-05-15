//
//  VAMenuTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAMenuTableViewCell : UITableViewCell
{
    
}
@property(strong,nonatomic)IBOutlet UIView *viewCellBg;
@property(strong,nonatomic)IBOutlet UILabel *lblMenuItemName;
@property(strong,nonatomic)IBOutlet UIImageView *imgViewIcon;

@end

NS_ASSUME_NONNULL_END
