//
//  VAAddServicesSettingViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 29/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAAddServicesSettingViewController.h"

@interface VAAddServicesSettingViewController ()
{
    NSMutableArray *arrayCategories;
    NSMutableArray *arrayCategoriesName;
    
    NSMutableArray *arraySubCategories;
    NSMutableArray *arraySubCategoriesNames;
    
    NSMutableArray *arrayLocations;
    NSMutableArray *arrayLocationName;
}

@end

@implementation VAAddServicesSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
    [self setupView];
    
    [self getCategories];
    [self getLocationsFromServer];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -- Other Methods

- (UIColor *)colorWithHexString:(NSString *)hex {
    NSString *cString = [[hex
                          stringByTrimmingCharactersInSet:[NSCharacterSet
                                                           whitespaceAndNewlineCharacterSet]]
                         uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}

-(void)showMessage:(NSString *)title meeeage:(NSString *)message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)setupView{
    [super addTopViewWithBackAndHeading];
    self.lblHeading.text=@"New Services";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
 
    self.viewServiceCategory.layer.masksToBounds = NO;
    self.viewServiceCategory.backgroundColor=[UIColor whiteColor];
    [self.viewServiceCategory setBackgroundColor:[UIColor whiteColor]];
    self.viewServiceCategory.delegate = self;
    
    self.viewServiceSubCategory.layer.masksToBounds = NO;
    self.viewServiceSubCategory.backgroundColor=[UIColor whiteColor];
    [self.viewServiceSubCategory setBackgroundColor:[UIColor whiteColor]];
    self.viewServiceSubCategory.delegate = self;
    
    self.viewServiceFrequency.layer.masksToBounds = NO;
    self.viewServiceFrequency.backgroundColor=[UIColor whiteColor];
    self.viewServiceFrequency.items = @[@"Visa", @"Master Visa", @"American Express",@"Capitabl One"];
    self.viewServiceFrequency.selectedItemIndex = 0;
    [self.viewServiceFrequency setBackgroundColor:[UIColor whiteColor]];
    
    self.viewSelectLocation.layer.masksToBounds = NO;
    self.viewSelectLocation.backgroundColor=[UIColor whiteColor];
    self.viewSelectLocation.items = @[@"USA", @"Pakistan", @"India",@"Russia",@"Saudia Arabia",@"UAE"];
    self.viewSelectLocation.selectedItemIndex = 0;
    [self.viewSelectLocation setBackgroundColor:[UIColor whiteColor]];
    
    self.btnSaveService.layer.masksToBounds = NO;
    self.btnSaveService.layer.cornerRadius = 10.0;
    
}

-(void)getCategories{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler getCategoryList];
}

-(void)getSubCategories:(NSString *)category_id{
    [objServerDataHandler getSubCategory:category_id];
}

-(void)getLocationsFromServer{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler getCompanyLocationList];
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)OnBtnSaveService:(id)sender{
    
    if([self.tbServiceName.text isEqualToString:@""] || [self.tbDescription.text isEqualToString:@""] || [self.tbEstimatedPrice.text isEqualToString:@""] || [self.tbPublish.text isEqualToString:@""] || [self.tbStatus.text isEqualToString:@""] || [self.tbCurency.text isEqualToString:@""] || [self.tbVideoLinks.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else
    {
        
        UserDC *objUserDc=[[UserDC alloc]init];
        objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
        
        NSString *strName = self.tbServiceName.text;
        NSString *strDetails = self.tbDescription.text;
        NSString *strCategory_id = [[arrayCategories objectAtIndex:self.viewServiceCategory.selectedItemIndex] objectForKey:@"rand_id"];
        NSString *strSubCategory_id = [[arraySubCategories objectAtIndex:self.viewServiceSubCategory.selectedItemIndex] objectForKey:@"rand_id"];
        NSString *strPrice = self.tbEstimatedPrice.text;
        NSString *strPublish = self.tbPublish.text;
        NSString *strStatus = self.tbStatus.text;
        NSString *strFrequency = self.viewServiceFrequency.items[self.viewServiceFrequency.selectedItemIndex];
        NSString *strCurrency = self.tbCurency.text;
        NSString *strVideo_links = self.tbVideoLinks.text;
        NSString *strCompanyID = objUserDc.user_id;
        NSString *strCompany_location_id = [arrayLocations objectAtIndex:self.viewSelectLocation.selectedItemIndex];
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [objServerDataHandler addNewServices:strName details:strDetails category_id:strCategory_id subcategory_id:strSubCategory_id price:strPrice publish:strPublish status:strStatus frequency:strFrequency currency:strCurrency video_links:strVideo_links company_id:strCompanyID company_location_id:strCompany_location_id];
    }
}

#pragma mark -- dropDown Delegate

- (void)dropDown:(TPSDropDown *)dropDown didSelectItemAtIndex:(NSInteger)index{
    
    if(dropDown == self.viewServiceCategory)
    {
         [self getSubCategories:[[arrayCategories objectAtIndex:index] objectForKey:@"rand_id"]];
    }
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseGetCategoryList) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayCategories=[[NSMutableArray alloc]init];
            arrayCategories=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            arrayCategoriesName = [[NSMutableArray alloc]init];
            
            for (NSMutableDictionary *dic in arrayCategories) {
                [arrayCategoriesName addObject:[dic objectForKey:@"name"]];
            }
            
            self.viewServiceCategory.items = [NSArray arrayWithArray:arrayCategoriesName];
            self.viewServiceCategory.selectedItemIndex = 0;
            
            [self getSubCategories:[[arrayCategories objectAtIndex:0] objectForKey:@"rand_id"]];
        }
        
    }
    if (typeID == kResponseGetSubCategory) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arraySubCategories=[[NSMutableArray alloc]init];
            arraySubCategories=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            arraySubCategoriesNames = [[NSMutableArray alloc]init];
            
            for (NSMutableDictionary *dic in arraySubCategories) {
                [arraySubCategoriesNames addObject:[dic objectForKey:@"name"]];
            }
            
            self.viewServiceSubCategory.items = [NSArray arrayWithArray:arraySubCategoriesNames];
            self.viewServiceSubCategory.selectedItemIndex = 0;
 
        }
    }
    
    if (typeID == kResponseGetCompanyLocationList) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayLocations=[[NSMutableArray alloc]init];
            arrayLocations=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            arrayLocationName = [[NSMutableArray alloc]init];
            
            for (NSMutableDictionary *dic in arrayLocations) {
                [arrayLocationName addObject:[dic objectForKey:@"name"]];
            }
            
            self.viewSelectLocation.items = [NSArray arrayWithArray:arrayLocationName];
            self.viewSelectLocation.selectedItemIndex = 0;
        }
    }
    if(typeID == kResponseAddNewServices)
    {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"success"] isEqualToString:@"true"])
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Vease"
                                                                            message:[[responce objectForKey:@"responceData"] objectForKey:@"data"] preferredStyle:UIAlertControllerStyleAlert];
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }];
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else
        {
//            [self showMessage:@"Vease" meeeage:[[responce objectForKey:@"responceData"] objectForKey:@"data"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}

@end
