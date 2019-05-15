//
//  VAAddCategoriesViewController.h
//  VeaseAdmin
//
//  Created by aliapple on 26/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VAAddCategoriesViewController : VAParentViewController<TPSDropDownDelegate>
{
    
}

@property (strong,nonatomic)IBOutlet UIButton *btnNext;
-(IBAction)onBtnNext:(id)sender;

@property (weak,nonatomic)IBOutlet TPSDropDown *viewCategory;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewSubCategory;
@property (weak,nonatomic)IBOutlet TPSDropDown *viewServices;

@property (weak,nonatomic)IBOutlet UIView *viewBottomBackground;

@end

NS_ASSUME_NONNULL_END
