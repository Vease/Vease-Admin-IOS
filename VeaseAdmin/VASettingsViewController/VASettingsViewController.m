//
//  VASettingsViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VASettingsViewController.h"

@interface VASettingsViewController ()
{
    NSMutableArray *arrayMenu;
}

@end

@implementation VASettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [super addMainTopViewWithMenu];
    [self.revealViewController tapGestureRecognizer];
    
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

#pragma mark -- Other Methods

-(void)setupView{
    
    //arrayMenu=[[NSMutableArray alloc]initWithObjects:@"General",@"Finance",@"Payment",@"Taxes",@"Role",@"Staff",@"Services",@"Bundles", nil];
    
    arrayMenu=[[NSMutableArray alloc]initWithObjects:@"General",@"Staff",@"Services", nil];
    
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.menuTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.menuTableView.backgroundColor=[UIColor clearColor];
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

#pragma mark--UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"SettingMenuCell";
    
    VASettingMenuTableViewCell *cell = (VASettingMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NSArray *nib;
    if (cell == nil) {
        nib = [[NSBundle mainBundle] loadNibNamed:@"VASettingMenuTableViewCell"
                                            owner:self
                                          options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblMenuItemName.text=[arrayMenu objectAtIndex:indexPath.row];
    
    // cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0)
    {
        //General
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAGeneralSettingViewController *objVAGeneralSettingViewController= (VAGeneralSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAGeneralSettingViewController"];
        [self.navigationController pushViewController:objVAGeneralSettingViewController animated:YES];
    }
    else if(indexPath.row==1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAStaffSettingViewController *objVAStaffSettingViewController= (VAStaffSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAStaffSettingViewController"];
        [self.navigationController pushViewController:objVAStaffSettingViewController animated:YES];
        /*
        //Finance
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAFinanceSettingViewController *objVAFinanceSettingViewController= (VAFinanceSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAFinanceSettingViewController"];
        [self.navigationController pushViewController:objVAFinanceSettingViewController animated:YES];
         */
    }
    else if(indexPath.row==2)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAServicesSettingsViewController *objVAServicesSettingsViewController= (VAServicesSettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAServicesSettingsViewController"];
        [self.navigationController pushViewController:objVAServicesSettingsViewController animated:YES];
        /*
        //Payment
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAPaymentSettingViewController *objVAPaymentSettingViewController= (VAPaymentSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAPaymentSettingViewController"];
        [self.navigationController pushViewController:objVAPaymentSettingViewController animated:YES];
         */
    }
    return;
    //else
    if(indexPath.row==3)
    {
        //Taxes
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VATaxesViewController *objVATaxesViewController= (VATaxesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VATaxesViewController"];
        [self.navigationController pushViewController:objVATaxesViewController animated:YES];
    }
    else if(indexPath.row==4)
    {
        //Role
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VARoleViewController *objVARoleViewController= (VARoleViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VARoleViewController"];
        [self.navigationController pushViewController:objVARoleViewController animated:YES];
    }
    else if(indexPath.row==5)
    {
        //Staff Setting
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAStaffSettingViewController *objVAStaffSettingViewController= (VAStaffSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAStaffSettingViewController"];
        [self.navigationController pushViewController:objVAStaffSettingViewController animated:YES];
    }
    else if(indexPath.row==6)
    {
        //Services
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VAServicesSettingsViewController *objVAServicesSettingsViewController= (VAServicesSettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAServicesSettingsViewController"];
        [self.navigationController pushViewController:objVAServicesSettingsViewController animated:YES];
    }
    else if(indexPath.row==7)
    {
        //Bundles
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        VABundlesSettingViewController *objVABundlesSettingViewController= (VABundlesSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VABundlesSettingViewController"];
        [self.navigationController pushViewController:objVABundlesSettingViewController animated:YES];
    }
    
}

@end

