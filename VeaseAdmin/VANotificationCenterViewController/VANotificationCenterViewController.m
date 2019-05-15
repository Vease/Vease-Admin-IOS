//
//  VANotificationCenterViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VANotificationCenterViewController.h"

@interface VANotificationCenterViewController ()
{
    NSMutableArray *arrayData;
}

@end

@implementation VANotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
    [super addMainTopViewWithMenu];
    [self.revealViewController tapGestureRecognizer];
    
    [self.notificationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.notificationTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.notificationTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.notificationTableView.backgroundColor=[UIColor clearColor];
    
    [self getDataFromServer];
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

-(void)getDataFromServer{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler rescheduleReques];
}

#pragma mark--UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"notificationCell";
    
    VANotificationTableViewCell *cell = (VANotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NSArray *nib;
    if (cell == nil) {
        nib = [[NSBundle mainBundle] loadNibNamed:@"VANotificationTableViewCell"
                                            owner:self
                                          options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UIView *viewBackground = (UIView *)[cell viewWithTag:100];
    viewBackground.layer.shadowRadius  = 1.5f;
    viewBackground.layer.shadowColor   = [UIColor grayColor].CGColor;
    viewBackground.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    viewBackground.layer.shadowOpacity = 0.9f;
    viewBackground.layer.masksToBounds = NO;
    
    NSMutableDictionary *dic = [arrayData objectAtIndex:indexPath.row];
    
    cell.lblCompany.text = [dic objectForKey:@"job_name"];
    cell.lblComments.text = [dic objectForKey:@"comments"];
    cell.lblStatus.text = [dic objectForKey:@"employee"];
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseRescheduleReques) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayData=[[NSMutableArray alloc]init];
            arrayData=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            self.notificationTableView.delegate=self;
            self.notificationTableView.dataSource=self;
            [self.notificationTableView reloadData];
        }
    }
    
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}


@end
