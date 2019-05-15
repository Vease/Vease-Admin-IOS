//
//  VAGeneralLocationTableViewCell.h
//  VeaseAdmin
//
//  Created by aliapple on 30/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAGeneralLocationTableViewCell : UITableViewCell
{
    
}

@property(strong,nonatomic)IBOutlet UILabel *lblLocationName;
@property(strong,nonatomic)IBOutlet UILabel *lblLocationAddress;

@property(strong,nonatomic)IBOutlet UILabel *lblShiftName;
@property(strong,nonatomic)IBOutlet UILabel *lblShiftPosition;
@property(strong,nonatomic)IBOutlet UILabel *lblShiftTo;
@property(strong,nonatomic)IBOutlet UILabel *lblShiftFrom;

@end

NS_ASSUME_NONNULL_END
