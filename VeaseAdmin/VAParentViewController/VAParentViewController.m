//
//  VAParentViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAParentViewController.h"

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface VAParentViewController ()

@end

@implementation VAParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

/*
#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

-(void)addMainTopViewWithMenu{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    topView.backgroundColor=[self colorWithHexString:@"2A2C3A"];
    
    topView.layer.masksToBounds = NO;
    topView.layer.shadowOffset = CGSizeMake(.0f,2.5f);
    topView.layer.shadowRadius = 1.5f;
    topView.layer.shadowOpacity = .9f;
    topView.layer.shadowColor = [UIColor blackColor].CGColor;
    topView.layer.shadowPath = [UIBezierPath bezierPathWithRect:topView.bounds].CGPath;
    
    SWRevealViewController *revealController = [self revealViewController];
    self.btnMenu=[[UIButton alloc]initWithFrame:CGRectMake(25, 25, 25, 25)];
    [self.btnMenu setImage:[UIImage imageNamed:@"ic_menu"] forState:UIControlStateNormal];
    [self.btnMenu addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *topViewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 58, self.view.frame.size.width, 2)];
    topViewLine.backgroundColor=[UIColor blackColor];
    //[self colorWithHexString:@"000000"];
    
    self.lblHeading=[[UILabel alloc]initWithFrame:CGRectMake(self.btnMenu.frame.origin.x+self.btnMenu.frame.size.width+30, 25, 150, 25)];
    self.lblHeading.font=[UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    //[UIFont systemFontOfSize:18.0];
    self.lblHeading.textColor=[UIColor whiteColor];
    self.lblHeading.text=@"Vease";
    self.lblHeading.textAlignment=NSTextAlignmentLeft;
    
    [topView addSubview:self.btnMenu];
    [topView addSubview:self.lblHeading];
    [self.view addSubview:topView];
}

-(void)addTopViewWithBack{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    topView.backgroundColor=[self colorWithHexString:@"2A2C3A"];
    topView.layer.masksToBounds = NO;
    topView.layer.shadowOffset = CGSizeMake(.0f,2.5f);
    topView.layer.shadowRadius = 1.5f;
    topView.layer.shadowOpacity = .9f;
    topView.layer.shadowColor = [UIColor blackColor].CGColor;
    topView.layer.shadowPath = [UIBezierPath bezierPathWithRect:topView.bounds].CGPath;
    
    self.btnMenu=[[UIButton alloc]initWithFrame:CGRectMake(25, 25, 25, 25)];
    [self.btnMenu setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
 
    UIView *topViewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 58, self.view.frame.size.width, 2)];
    topViewLine.backgroundColor=[UIColor blackColor];
    //[self colorWithHexString:@"000000"];
    
    self.lblHeading=[[UILabel alloc]initWithFrame:CGRectMake(self.btnMenu.frame.origin.x+self.btnMenu.frame.size.width+30, 25, 150, 25)];
    self.lblHeading.font=[UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    //[UIFont systemFontOfSize:18.0];
    self.lblHeading.textColor=[UIColor whiteColor];
    self.lblHeading.text=@"Vease";
    self.lblHeading.textAlignment=NSTextAlignmentLeft;
    
    [topView addSubview:self.btnMenu];
    [topView addSubview:self.lblHeading];
    [self.view addSubview:topView];
}

-(void)addTopViewWithBackAndHeading{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    topView.backgroundColor=[self colorWithHexString:@"2A2C3A"];
    topView.layer.masksToBounds = NO;
    topView.layer.shadowOffset = CGSizeMake(.0f,2.5f);
    topView.layer.shadowRadius = 1.5f;
    topView.layer.shadowOpacity = .9f;
    topView.layer.shadowColor = [UIColor blackColor].CGColor;
    topView.layer.shadowPath = [UIBezierPath bezierPathWithRect:topView.bounds].CGPath;
    
    self.btnMenu=[[UIButton alloc]initWithFrame:CGRectMake(25, 25, 25, 25)];
    [self.btnMenu setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    
    UIView *topViewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 58, self.view.frame.size.width, 2)];
    topViewLine.backgroundColor=[UIColor blackColor];
    //[self colorWithHexString:@"000000"];
    
    self.lblHeading=[[UILabel alloc]initWithFrame:CGRectMake(self.btnMenu.frame.origin.x+self.btnMenu.frame.size.width+30, 25, 150, 25)];
    self.lblHeading.font=[UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.lblHeading.textColor=[UIColor whiteColor];
    self.lblHeading.textAlignment=NSTextAlignmentLeft;
    
    [topView addSubview:self.btnMenu];
    [topView addSubview:self.lblHeading];
    [self.view addSubview:topView];
}

@end
