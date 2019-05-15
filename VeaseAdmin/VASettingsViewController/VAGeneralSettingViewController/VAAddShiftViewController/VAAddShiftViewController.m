//
//  VAAddShiftViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAAddShiftViewController.h"

@interface VAAddShiftViewController ()

@end

@implementation VAAddShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
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
    self.lblHeading.text=@"Vease";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewSource.layer.masksToBounds = NO;
    self.viewSource.layer.borderWidth=2.0;
    self.viewSource.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewSource.layer.cornerRadius=5.0;
    self.viewSource.items = @[@"the okay schedule", @"Toronto Branch Schedule", @"Black Friday"];
    self.viewSource.selectedItemIndex = 0;
    [self.viewSource setBackgroundColor:[UIColor whiteColor]];
    
    self.viewPosition.layer.masksToBounds = NO;
    self.viewPosition.layer.borderWidth=2.0;
    self.viewPosition.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewPosition.layer.cornerRadius=5.0;
    self.viewPosition.items = @[@"NO Position", @"Manager HR", @"DB Admin",@"Marketer"];
    self.viewPosition.selectedItemIndex = 0;
    [self.viewPosition setBackgroundColor:[UIColor whiteColor]];
    
    self.btnSave.layer.cornerRadius=10.0;
    
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnSave:(id)sender{
    if([self.tbScheduleName.text isEqualToString:@""] || [self.tbUnpaidBreak.text isEqualToString:@""] || [self.tbNotes.text isEqualToString:@""] || [self.tbTo.text isEqualToString:@""] || [self.tbFrom.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else
    {
        NSString *strScheduleName = self.tbScheduleName.text;
        NSString *strUnpaidBreak = self.tbUnpaidBreak.text;
        NSString *strNotes = self.tbNotes.text;
        NSString *strScheduleID = self.viewSource.items[self.viewSource.selectedItemIndex];
        NSString *strPosition = self.viewPosition.items[self.viewPosition.selectedItemIndex];
        NSString *strTO = self.tbTo.text;
        NSString *strFrom = self.tbFrom.text;
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        
        [objServerDataHandler addShift:strScheduleName unpaid_break:strUnpaidBreak schedule_id:strScheduleID to:strTO from:strFrom notes:strNotes position:strPosition];
        
    }
}

-(IBAction)onBtnTo:(id)sender{
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:@"To" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeTime
                   callback:^(NSDate * _Nullable date){
                       if(date)
                       {
                           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                           [formatter setDateStyle:NSDateFormatterMediumStyle];
                           NSLog(@"Date selected: %@",[formatter stringFromDate:date]);
                           
                          // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                         //  dateFormatter.dateFormat = @"MM/dd/yy";
                           
                           //NSString *dateString = [dateFormatter stringFromDate: date];
                           
                           NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
                           timeFormatter.dateFormat = @"HH:mm:ss";
                           NSString *timeString = [timeFormatter stringFromDate: date];
                           
                           self.tbTo.text = timeString;
                       }
                   }
     ];
}

-(IBAction)onBtnFrom:(id)sender{
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:@"From" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeTime
                   callback:^(NSDate * _Nullable date){
                       if(date)
                       {
                           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                           [formatter setDateStyle:NSDateFormatterMediumStyle];
                           NSLog(@"Date selected: %@",[formatter stringFromDate:date]);
                         
                           
                           NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
                           timeFormatter.dateFormat = @"HH:mm:ss";
                           NSString *timeString = [timeFormatter stringFromDate: date];
                           
                           self.tbFrom.text = timeString;
                       }
                   }
     ];
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseAddShift) {
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
