//
//  VAAddTaxViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAAddTaxViewController.h"

@interface VAAddTaxViewController ()

@end

@implementation VAAddTaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
    [self setupView];
    
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
    self.lblHeading.text=@"New Tax";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewDropDown.layer.masksToBounds = NO;
//    self.viewDropDown.layer.borderWidth=2.0;
//    self.viewDropDown.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
//    self.viewDropDown.layer.cornerRadius=5.0;
    self.viewDropDown.items = @[@"Federal", @"Provincial", @"Federl & Provincial"];
    self.viewDropDown.selectedItemIndex = 0;
    [self.viewDropDown setBackgroundColor:[UIColor whiteColor]];
    
    self.btnSave.layer.masksToBounds = NO;
    self.btnSave.layer.cornerRadius=10.0f;
    
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnSave:(id)sender{
    
    if([self.tbTaxName.text isEqualToString:@""] || [self.tbPercentage.text isEqualToString:@""] || [self.tbDummyInput.text isEqualToString:@""] || [self.tbDescription.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else
    {
    
        [SVProgressHUD showWithStatus:@"Please wait..."];
        
        [objServerDataHandler createCompanyTax:self.tbTaxName.text percentage:self.tbPercentage.text jurisdiction:self.viewDropDown.items[self.viewDropDown.selectedItemIndex] description:self.tbDescription.text dumpy_input:self.tbDummyInput.text];
    }
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    
    if(typeID == kResponseCreateCompanyTax)
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
            [self showMessage:@"Vease" meeeage:[[responce objectForKey:@"responceData"] objectForKey:@"data"]];
        }
    }
    
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}


@end
