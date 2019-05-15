//
//  VARegisterViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VARegisterViewController.h"

@interface VARegisterViewController ()

@end

@implementation VARegisterViewController

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

-(void)setupView{
    
    self.imgViewBackground.image=[self blurredImageWithImage:[UIImage imageNamed:@"ic_loginBG"]];
    
    self.viewUsername.layer.masksToBounds = NO;
    self.viewUsername.layer.cornerRadius=25;
    self.viewUsername.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewUsername.layer.borderWidth = 2.0f;
    
    self.viewEmail.layer.masksToBounds = NO;
    self.viewEmail.layer.cornerRadius=25;
    self.viewEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewEmail.layer.borderWidth = 2.0f;
    
    self.viewPassword.layer.masksToBounds = NO;
    self.viewPassword.layer.cornerRadius=25;
    self.viewPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewPassword.layer.borderWidth = 2.0f;
    
    self.viewConfirmPassword.layer.masksToBounds = NO;
    self.viewConfirmPassword.layer.cornerRadius=25;
    self.viewConfirmPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewConfirmPassword.layer.borderWidth = 2.0f;
    
    self.btnRegister.layer.masksToBounds = NO;
    self.btnRegister.layer.cornerRadius=25;
}

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

- (BOOL)validateEmailWithString:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (UIImage *)blurredImageWithImage:(UIImage *)sourceImage{
    
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:8.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *retVal = [UIImage imageWithCGImage:cgImage];
    
    if (cgImage) {
        CGImageRelease(cgImage);
    }
    
    return retVal;
}

#pragma mark-- IBAction Methods

-(IBAction)OnBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)OnBtnRegister:(id)sender{
    if([self.tbUsername.text isEqualToString:@""] || [self.tbEmail.text isEqualToString:@""] || [self.tbPassword.text isEqualToString:@""] || [self.tbConfirmPassword.text isEqualToString:@""] || [self.tbConfirmPassword.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else if(![self validateEmailWithString:self.tbEmail.text])
    {
        [self showMessage:@"Vease" meeeage:@"Invalid email address"];
    }
    else if(![self.tbPassword.text isEqualToString:self.tbConfirmPassword.text])
    {
        [self showMessage:@"Vease" meeeage:@"Password do not match"];
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [objServerDataHandler registerCompany:self.tbUsername.text email:self.tbEmail.text password:self.tbPassword.text c_password:self.tbConfirmPassword.text];
    }
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseRegisterCompany) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"]objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSMutableDictionary *dic=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            NSMutableDictionary *dicEmail =[[NSMutableDictionary alloc]init];
            [dicEmail setObject:self.tbEmail.text forKey:@"email"];
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Vease"
                                         message:[dic objectForKey:@"message"]
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                            if ([self.delegateObject respondsToSelector:@selector(companyEmail:)]) {
                                                [self.delegateObject companyEmail:dicEmail];
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }
                                            
                                        }];
            
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
   
            //
            //            [self showMessage:@"Vease" meeeage:[dic objectForKey:@"message"]];
            
        }
        else
        {
            [self showMessage:@"Vease" meeeage:[[[responce objectForKey:@"responceData"] objectForKey:@"data"] objectForKey:@"message"]];
        }
        
    }
    
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}


@end
