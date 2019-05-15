//
//  VAMenuViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAMenuViewController : UIViewController<MKDropdownMenuDelegate,MKDropdownMenuDataSource,UITableViewDelegate,UITableViewDataSource>
{
    
}

@property(strong,nonatomic)IBOutlet UIView *viewIntroBack;
@property(strong,nonatomic)IBOutlet UIImageView *imgViewProfile;
@property(strong,nonatomic)IBOutlet UILabel *lblUsername;
@property(strong,nonatomic)IBOutlet UILabel *lblEmail;

@property(strong,nonatomic)IBOutlet MKDropdownMenu *mkDropdownMenu;

@property(strong,nonatomic)IBOutlet UITableView *menuTableView;

@end


NS_ASSUME_NONNULL_END
