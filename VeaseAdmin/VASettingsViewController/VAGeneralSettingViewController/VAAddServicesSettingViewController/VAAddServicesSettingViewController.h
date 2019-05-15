//
//  VAAddServicesSettingViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 29/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAAddServicesSettingViewController : VAParentViewController<ServerDataHandlerDelegate,TPSDropDownDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property (weak,nonatomic)IBOutlet TPSDropDown *viewServiceCategory;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewServiceSubCategory;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbServiceName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbDescription;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewServiceFrequency;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbEstimatedPrice;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbPublish;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbStatus;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbCurency;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewSelectLocation;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbVideoLinks;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveService;
-(IBAction)OnBtnSaveService:(id)sender;

@end

NS_ASSUME_NONNULL_END
