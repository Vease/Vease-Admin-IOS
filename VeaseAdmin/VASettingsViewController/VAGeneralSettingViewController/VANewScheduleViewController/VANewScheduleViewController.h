//
//  VANewScheduleViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VANewScheduleViewController : VAParentViewController<ServerDataHandlerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbName;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewCountry;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbTo;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbFrom;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbHours;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewDays;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
-(IBAction)onBtnSave:(id)sender;

@property (weak,nonatomic)IBOutlet UIButton *btnTo;
-(IBAction)onBtnTo:(id)sender;

@property (weak,nonatomic)IBOutlet UIButton *btnFrom;
-(IBAction)onBtnFrom:(id)sender;




@end

NS_ASSUME_NONNULL_END
