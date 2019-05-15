//
//  VAPaymentSettingViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 29/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAPaymentSettingViewController : VAParentViewController<TYPagerViewDataSource, TYPagerViewDelegate,TYTabPagerBarDataSource,TYTabPagerBarDelegate,TPSDropDownDelegate>
{
    
}


@property (weak, nonatomic) IBOutlet UIImageView *imgPayInvoiceYes;
@property (weak, nonatomic) IBOutlet UIButton *btnPayInvoiceYes;
-(IBAction)onBtnPayInvoiceYes:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgPayInvoiceNO;
@property (weak, nonatomic) IBOutlet UIButton *btnPayInvoiceNO;
-(IBAction)onBtnPayInvoiceNO:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgAmountToPayYes;
@property (weak, nonatomic) IBOutlet UIButton *btnAmountToPayYes;
-(IBAction)onBtnAmountToPayYes:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgAmountToPayNO;
@property (weak, nonatomic) IBOutlet UIButton *btnAmountToPayNO;
-(IBAction)onBtnAmountToPayNO:(id)sender;

@property(strong,nonnull)IBOutlet UITableView *paypalTableView;
@property(strong,nonnull)IBOutlet UITableView *creditCardTableView;
@property(strong,nonnull)IBOutlet UITableView *stripeTableView;

@end

NS_ASSUME_NONNULL_END

