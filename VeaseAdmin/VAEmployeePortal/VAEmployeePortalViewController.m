//
//  VAEmployeePortalViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 15/04/2019.
//  Copyright © 2019 aliapple. All rights reserved.
//

#import "VAEmployeePortalViewController.h"

@interface VAEmployeePortalViewController ()
{
    NSArray *arrayMenuItems;
}

@end

@implementation VAEmployeePortalViewController

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
    
//     arrayMenuItems=[[NSMutableArray alloc]initWithObjects:@"Jobs",@"Work History",@"Reschedule Form",@"Submit a Leave", nil];
    
   arrayMenuItems = @[@{@"name":@"Jobs", @"icon":@"ic_Job"},
      @{@"name":@"Work History", @"icon": @"ic_WorkHistory"},
      @{@"name":@"Reschedule Form", @"icon": @"ic_Reschedule"},
                      @{@"name":@"Submit a Leave", @"icon": @"ic_SubmitALeave"}];
    
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
    return [arrayMenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"menuCell";
    
    VAMenuTableViewCell *cell = (VAMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NSArray *nib;
    if (cell == nil) {
        nib = [[NSBundle mainBundle] loadNibNamed:@"VAMenuTableViewCell"
                                            owner:self
                                          options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = [arrayMenuItems objectAtIndex:indexPath.row];
    
    cell.lblMenuItemName.text=[dic objectForKey:@"name"];
    
    cell.lblMenuItemName.textColor=[UIColor whiteColor];
    cell.imgViewIcon.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    cell.viewCellBg.backgroundColor=[UIColor clearColor];

    cell.viewCellBg.layer.cornerRadius=5.0;
    
    // cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(indexPath.row==0)
//    {
//        //General
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        VAGeneralSettingViewController *objVAGeneralSettingViewController= (VAGeneralSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAGeneralSettingViewController"];
//        [self.navigationController pushViewController:objVAGeneralSettingViewController animated:YES];
//    }
//    else if(indexPath.row==1)
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        VAStaffSettingViewController *objVAStaffSettingViewController= (VAStaffSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAStaffSettingViewController"];
//        [self.navigationController pushViewController:objVAStaffSettingViewController animated:YES];
//        /*
//         //Finance
//         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//         VAFinanceSettingViewController *objVAFinanceSettingViewController= (VAFinanceSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAFinanceSettingViewController"];
//         [self.navigationController pushViewController:objVAFinanceSettingViewController animated:YES];
//         */
//    }
//    else if(indexPath.row==2)
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        VAServicesSettingsViewController *objVAServicesSettingsViewController= (VAServicesSettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAServicesSettingsViewController"];
//        [self.navigationController pushViewController:objVAServicesSettingsViewController animated:YES];
//        /*
//         //Payment
//         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//         VAPaymentSettingViewController *objVAPaymentSettingViewController= (VAPaymentSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAPaymentSettingViewController"];
//         [self.navigationController pushViewController:objVAPaymentSettingViewController animated:YES];
//         */
//    }
//    return;
//    //else
    
    
}


@end
