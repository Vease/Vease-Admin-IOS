//
//  VAGeneralSettingViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAGeneralSettingViewController : VAParentViewController<TYPagerViewDataSource, TYPagerViewDelegate,TYTabPagerBarDataSource,TYTabPagerBarDelegate,TPSDropDownDelegate,ServerDataHandlerDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbCompanyName;
@property (strong,nonatomic)IBOutlet TPSDropDown *viewSource;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbProvince;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbCity;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbDomainName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbAddress;
@property (strong,nonatomic)IBOutlet TPSDropDown *viewCountry;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbPhone;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
-(IBAction)onBtnUpdate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdateImage;
-(IBAction)onBtnUpdateImage:(id)sender;

@end

NS_ASSUME_NONNULL_END
