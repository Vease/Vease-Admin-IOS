//
//  VAAddTaxViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAAddTaxViewController : VAParentViewController<ServerDataHandlerDelegate>
{
    ServerDataHandler *objServerDataHandler;
}

@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbTaxName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbPercentage;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbDummyInput;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *tbDescription;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewDropDown;

@property (weak,nonatomic)IBOutlet UIButton *btnSave;
-(IBAction)onBtnSave:(id)sender;

@end

NS_ASSUME_NONNULL_END
