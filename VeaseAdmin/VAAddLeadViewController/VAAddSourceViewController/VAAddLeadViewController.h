//
//  VAAddLeadViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 26/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAAddLeadViewController : VAParentViewController<UITextFieldDelegate,TPSDropDownDelegate>
{
    
}

@property (weak,nonatomic)IBOutlet TPSDropDown *viewSource;

@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbFirstName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbLastName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbPhoneNumber;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbEmail;

@property (strong,nonatomic)IBOutlet UIButton *btnNext;
-(IBAction)onBtnNext:(id)sender;

@property (weak,nonatomic)IBOutlet UIView *viewBottomBackground;


@end

NS_ASSUME_NONNULL_END
