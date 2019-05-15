//
//  VARegisterViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol companyEmail <NSObject>

@optional;
-(void)companyEmail:(NSMutableDictionary *)dic;
@end

@interface VARegisterViewController : UIViewController <ServerDataHandlerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}


@property(strong,nonatomic)IBOutlet UIButton *btnBack;
-(IBAction)OnBtnBack:(id)sender;

@property(strong,nonatomic)IBOutlet UIView *viewUsername;
@property(strong,nonatomic)IBOutlet UITextField *tbUsername;

@property(strong,nonatomic)IBOutlet UIView *viewEmail;
@property(strong,nonatomic)IBOutlet UITextField *tbEmail;

@property(strong,nonatomic)IBOutlet UIView *viewPassword;
@property(strong,nonatomic)IBOutlet UITextField *tbPassword;

@property(strong,nonatomic)IBOutlet UIView *viewConfirmPassword;
@property(strong,nonatomic)IBOutlet UITextField *tbConfirmPassword;

@property(strong,nonatomic)IBOutlet UIButton *btnRegister;
-(IBAction)OnBtnRegister:(id)sender;

@property(strong,nonatomic)IBOutlet UIImageView *imgViewBackground;

@property (nonatomic, strong) id <companyEmail> delegateObject;

@end

NS_ASSUME_NONNULL_END
