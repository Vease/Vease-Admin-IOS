//
//  VASignInViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VASignInViewController.h"

@interface VASignInViewController ()<companyEmail>

@end

@implementation VASignInViewController

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
    
    self.viewPassword.layer.masksToBounds = NO;
    self.viewPassword.layer.cornerRadius=25;
    self.viewPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewPassword.layer.borderWidth = 2.0f;
    
    self.btnLogin.layer.masksToBounds = NO;
    self.btnLogin.layer.cornerRadius=25;
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

-(void)companyEmail:(NSMutableDictionary *)dic{
    if(dic)
    {
        self.tbUsername.text=[dic objectForKey:@"email"];
    }
}

#pragma mark -- IBAction Methods

-(IBAction)OnBtnLogin:(id)sender{
    NSLog(@"User Tap on SignIn Button");
    
    if([self.tbUsername.text isEqualToString:@""] || [self.tbPassword.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else if(![self validateEmailWithString:self.tbUsername.text])
    {
        [self showMessage:@"Vease" meeeage:@"Invalid email address"];
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [objServerDataHandler userLogin:self.tbUsername.text password:self.tbPassword.text];
    }
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    VAHomeViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VAHomeViewController"];
//    VAMenuViewController *rearNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"VAMenuViewController"];
//
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
//    [navController setViewControllers: @[rootViewController] animated: YES];
//
//    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:navController];
//
//    revealController.delegate = self;
//    self.view.window.rootViewController = revealController;
}

-(IBAction)OnBtnForgotPassword:(id)sender{
    
}

-(IBAction)OnBtnRegister:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    VARegisterViewController *objVARegisterViewController= (VARegisterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VARegisterViewController"];
    objVARegisterViewController.delegateObject=self;
    [self.navigationController pushViewController:objVARegisterViewController animated:YES];
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseUserLogin) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"]objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSMutableDictionary *dic=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            if(dic)
            {
                UserDC *objUserDC=[[UserDC alloc]init];
                objUserDC.application_fee = dic[@"application_fee"];
                objUserDC.company_stripe_account = dic[@"company_stripe_account"];
                objUserDC.email = dic[@"email"];
                objUserDC.name = dic[@"name"];
                objUserDC.token = dic[@"token"];
                objUserDC.user_id = dic[@"user_id"];
                objUserDC.is_login = @"1";
               [[VAGlobalInstance getInstance] saveCustomObject:objUserDC key:@"userInfo"];
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                VAHomeViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"VAHomeViewController"];
                VAMenuViewController *rearNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"VAMenuViewController"];
                
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
                [navController setViewControllers: @[rootViewController] animated: YES];
                
                SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:navController];
                
                revealController.delegate = self;
                self.view.window.rootViewController = revealController;
            }
            else
            {
                [self showMessage:@"Vease" meeeage:[[[responce objectForKey:@"responceData"] objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
    }
  
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}

@end
