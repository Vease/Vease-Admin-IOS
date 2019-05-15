//
//  VAAddShiftViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAAddShiftViewController : VAParentViewController<ServerDataHandlerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbScheduleName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbUnpaidBreak;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbNotes;
@property (strong,nonatomic)IBOutlet TPSDropDown *viewSource;
@property (strong,nonatomic)IBOutlet TPSDropDown *viewPosition;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbTo;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbFrom;

@property (weak,nonatomic)IBOutlet UIButton *btnTo;
-(IBAction)onBtnTo:(id)sender;

@property (weak,nonatomic)IBOutlet UIButton *btnFrom;
-(IBAction)onBtnFrom:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
-(IBAction)onBtnSave:(id)sender;

@end

NS_ASSUME_NONNULL_END

