//
//  VASignInViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASignInViewController : UIViewController <SWRevealViewControllerDelegate,ServerDataHandlerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property(strong,nonatomic)IBOutlet UIView *viewUsername;
@property(strong,nonatomic)IBOutlet UITextField *tbUsername;

@property(strong,nonatomic)IBOutlet UIView *viewPassword;
@property(strong,nonatomic)IBOutlet UITextField *tbPassword;

@property(strong,nonatomic)IBOutlet UIButton *btnLogin;
-(IBAction)OnBtnLogin:(id)sender;

@property(strong,nonatomic)IBOutlet UIButton *btnForgotPassword;
-(IBAction)OnBtnForgotPassword:(id)sender;

@property(strong,nonatomic)IBOutlet UIButton *btnRegister;
-(IBAction)OnBtnRegister:(id)sender;

@property(strong,nonatomic)IBOutlet UIImageView *imgViewBackground;

@end

NS_ASSUME_NONNULL_END
