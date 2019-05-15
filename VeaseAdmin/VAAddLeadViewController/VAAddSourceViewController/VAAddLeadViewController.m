//
//  VAAddLeadViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 26/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAAddLeadViewController.h"

@interface VAAddLeadViewController ()

@end

@implementation VAAddLeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self setupView];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//ic_arrowDown

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
    [super addTopViewWithBack];
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewSource.layer.masksToBounds = NO;
    self.viewSource.layer.borderWidth=2.0;
    self.viewSource.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewSource.layer.cornerRadius=5.0;
    
    self.viewSource.items = @[@"(GMT-12:00) International Date Line West", @"(GMT-13:00) midway Island, Samoa", @"(GMT-10:00) Hawaii",@"(GMT-9:00) Alaska"];
    self.viewSource.selectedItemIndex = 0;
    self.viewSource.delegate = self;
    [self.viewSource setBackgroundColor:[UIColor whiteColor]];
    
    self.viewBottomBackground.layer.shadowRadius  = 1.5f;
    self.viewBottomBackground.layer.shadowColor   = [UIColor grayColor].CGColor;
    self.viewBottomBackground.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    self.viewBottomBackground.layer.shadowOpacity = 0.9f;
    self.viewBottomBackground.layer.masksToBounds = NO;
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnNext:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    VAAddCategoriesViewController *objVAAddCategoriesViewController= (VAAddCategoriesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAAddCategoriesViewController"];
    [self.navigationController pushViewController:objVAAddCategoriesViewController animated:YES];
    
}

@end
