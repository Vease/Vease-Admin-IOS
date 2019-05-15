//
//  VAParentViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VAParentViewController : UIViewController
{
    
}

@property(strong,nonatomic)IBOutlet UIButton *btnMenu;
@property(strong,nonatomic)IBOutlet UILabel *lblHeading;


-(void)addMainTopViewWithMenu;
-(void)addTopViewWithBack;
-(void)addTopViewWithBackAndHeading;

@end

NS_ASSUME_NONNULL_END
