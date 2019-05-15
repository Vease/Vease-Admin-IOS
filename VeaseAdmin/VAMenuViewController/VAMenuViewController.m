//
//  VAMenuViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAMenuViewController.h"

@interface VAMenuViewController ()
{
    NSArray *arrayMenuItems;
    NSInteger _presentedRow;
}

@end

@implementation VAMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    arrayMenuItems = @[@{@"name":@"Home", @"icon":@"ic_home", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Lead", @"icon": @"ic_Lead", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Services", @"icon": @"ic_Services", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Staff", @"icon": @"ic_Staff", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Notification Center", @"icon": @"ic_NotificationCenter", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Settings", @"icon": @"ic_settings", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Logout", @"icon": @"ic_Logout", @"iconSelected": @"ic_settings_Green"},
                      @{@"name":@"Employee Portal", @"icon": @"ic_EmployeePortal", @"iconSelected": @"ic_settings_Green"}];
    
    [self setupView];

//    self.mkDropdownMenu.dataSource = self;
//    self.mkDropdownMenu.delegate = self;
   
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
    
    UserDC *userDc=[[UserDC alloc]init];
    userDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    self.viewIntroBack.layer.shadowRadius  = 1.5f;
    self.viewIntroBack.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.viewIntroBack.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    self.viewIntroBack.layer.shadowOpacity = 0.9f;
    self.viewIntroBack.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.viewIntroBack.bounds, shadowInsets)];
    self.viewIntroBack.layer.shadowPath    = shadowPath.CGPath;
    
    self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.size.height /2;
    self.imgViewProfile.layer.masksToBounds = YES;
    self.imgViewProfile.layer.borderWidth = 0;
    
    self.lblUsername.text = userDc.name;
    self.lblEmail.text = userDc.email;
    
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

-(void)logoutUser{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Vease"
                                 message:@"Are you sure you want to logout?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    //Handle your yes please button action here
                                    [self goToLoginView];
                                    
                                }];
    
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)goToLoginView{
    UserDC * objUserDC=[[UserDC alloc]init];
    objUserDC=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    objUserDC=nil;
    [[VAGlobalInstance getInstance] saveCustomObject:objUserDC key:@"userInfo"];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VASignInViewController *objVASignInViewController =[storyboard instantiateViewControllerWithIdentifier:@"VASignInViewController"];
    UINavigationController *objNavigationController =
    [[UINavigationController alloc] initWithRootViewController:objVASignInViewController];
    [objNavigationController.navigationBar setHidden:YES];
    self.view.window.rootViewController = objNavigationController;
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
    
    if(indexPath.row==_presentedRow)
    {
        cell.lblMenuItemName.textColor=[self colorWithHexString:@"2FC55D"];
        //cell.imgViewIcon.image = [UIImage imageNamed:[dic objectForKey:@"iconSelected"]];
        cell.viewCellBg.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        cell.lblMenuItemName.textColor=[UIColor whiteColor];
        cell.imgViewIcon.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
        cell.viewCellBg.backgroundColor=[UIColor clearColor];
    }

    cell.viewCellBg.layer.cornerRadius=5.0;
    
    // cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController *revealController = self.revealViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle: nil];
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if (row == _presentedRow)
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    
    // otherwise we'll create a new frontViewController and push it with animation
    
    UIViewController *newFrontController = nil;
    
    if (row == 0)
    {
        //Home
        VAHomeViewController *objVAHomeViewController= (VAHomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAHomeViewController"];
        newFrontController = objVAHomeViewController;
    }
    else if (row == 1)
    {
        //Lead
        VALeadViewController *objVALeadViewController= (VALeadViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VALeadViewController"];
        newFrontController = objVALeadViewController;
    }
    else if (row == 2)
    {
        //Services
        VAServicesViewController *objVAServicesViewController= (VAServicesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAServicesViewController"];
        newFrontController = objVAServicesViewController;
    }
    else if (row == 3)
    {
        //Staff
        VAStaffViewController *objVAStaffViewController= (VAStaffViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAStaffViewController"];
        newFrontController = objVAStaffViewController;
    }
    else if (row == 41)
    {
//        VAEstimatedResponseViewController *objVAEstimatedResponseViewController= (VAEstimatedResponseViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAEstimatedResponseViewController"];
//        newFrontController = objVAEstimatedResponseViewController;
    }
    else if (row == 51)
    {
//        VAResolutionCenterViewController *objVAResolutionCenterViewController= (VAResolutionCenterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAResolutionCenterViewController"];
//        newFrontController = objVAResolutionCenterViewController;
    }
    else if (row == 4)
    {
         //Notification Center
        VANotificationCenterViewController *objVANotificationCenterViewController= (VANotificationCenterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VANotificationCenterViewController"];
        newFrontController = objVANotificationCenterViewController;
    }
    else if (row == 5)
    {
        //Settings
        VASettingsViewController *objVASettingsViewController= (VASettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VASettingsViewController"];
        newFrontController = objVASettingsViewController;
        
        
       /* VAGeneralSettingViewController *objVAGeneralSettingViewController= (VAGeneralSettingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAGeneralSettingViewController"];
        newFrontController = objVAGeneralSettingViewController;
        */
    }
    else if (row == 6)
    {
        // Logout
        [self logoutUser];
        return;
    }
    else if (row == 7)
    {
        //Employee Portal
        VAEmployeePortalViewController *objVAEmployeePortalViewController= (VAEmployeePortalViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAEmployeePortalViewController"];
        newFrontController = objVAEmployeePortalViewController;
    }
 
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController.navigationController.navigationBar setHidden:YES];
    [revealController pushFrontViewController:navigationController animated:YES];

    _presentedRow = row;
    [self.menuTableView reloadData];
}

@end
