//
//  VAFinanceSettingViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAFinanceSettingViewController : VAParentViewController<TYPagerViewDataSource, TYPagerViewDelegate,TYTabPagerBarDataSource,TYTabPagerBarDelegate,TPSDropDownDelegate>
{
    
}

@property (weak,nonatomic)IBOutlet TPSDropDown *viewDecemalSeprator;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewThousandSeprartor;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbDefaultTax;

@property (weak, nonatomic) IBOutlet UIImageView *imgCurrenceSelectedBefore;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrenceSelectedBefore;
-(IBAction)onBtnCurrenceSelectedBefore:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgCurrenceSelectedAfter;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrenceSelectedAfter;
-(IBAction)onBtnCurrenceSelectedAfter:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgTaxPerItemYes;
@property (weak, nonatomic) IBOutlet UIButton *btnTaxPerItemYes;
-(IBAction)onBtnTaxPerItemYes:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgTaxPerItemNO;
@property (weak, nonatomic) IBOutlet UIButton *btnTaxPerItemNO;
-(IBAction)onBtnTaxPerItemNO:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
-(IBAction)onBtnSave:(id)sender;

@property (weak,nonatomic)IBOutlet TPSDropDown *viewInvoiceNumberPrefix;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewInvoiceNumber;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewDueAfterDate;

@property (weak, nonatomic) IBOutlet UIImageView *imgInvoiceYes;
@property (weak, nonatomic) IBOutlet UIButton *btnInvoiceYes;
-(IBAction)onBtnInvoiceYes:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgInvoiceNO;
@property (weak, nonatomic) IBOutlet UIButton *btnInvoiceNO;
-(IBAction)onBtnInvoiceNO:(id)sender;

@end

NS_ASSUME_NONNULL_END

