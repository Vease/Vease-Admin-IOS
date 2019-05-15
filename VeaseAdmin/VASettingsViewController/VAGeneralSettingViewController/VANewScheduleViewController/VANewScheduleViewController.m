//
//  VANewScheduleViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VANewScheduleViewController.h"

@interface VANewScheduleViewController ()
{
    NSMutableArray *arrayLocations;
    NSMutableArray *arrayLocationName;
    
}

@end

@implementation VANewScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
    [self setupView];
    
    [self getLocationsFromServer];
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
    self.lblHeading.text=@"New Schedule";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewCountry.layer.masksToBounds = NO;
    self.viewCountry.layer.borderWidth=2.0;
    self.viewCountry.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewCountry.layer.cornerRadius=5.0;
//    self.viewCountry.items = @[@"Toronto Branch", @"Ontario", @"Ontario Branch",@"Home Cleaning",@"Barbar Shop",@"Car Wash Canada",@"Hair Dresser",@"Personal Care",@"Make Up",@"Lawn Care Company",@"PWD"];
  //  self.viewCountry.selectedItemIndex = 0;
    [self.viewCountry setBackgroundColor:[UIColor whiteColor]];
    
    self.viewDays.layer.masksToBounds = NO;
    self.viewDays.layer.borderWidth=2.0;
    self.viewDays.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewDays.layer.cornerRadius=5.0;
    self.viewDays.items = @[@"Monday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday"];
      self.viewDays.selectedItemIndex = 0;
    [self.viewDays setBackgroundColor:[UIColor whiteColor]];
    
    self.btnSave.layer.cornerRadius=10.0;
    
}

-(void)getLocationsFromServer{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler getCompanyLocationList];
}

#pragma Mark -- Get the INTERNAL ip address

- (NSString *)getIPAddress {
    
    NSDictionary *dict = [self getIPAddresses];
    if ([dict objectForKey:@"en0/ipv4"]) {
        NSLog(@"You are connected to wifi network: %@",[dict objectForKey:@"en0/ipv4"]);
        return [dict objectForKey:@"en0/ipv4"];
    } else if ([dict objectForKey:@"pdp_ip0/ipv4"]) {
        NSLog(@"You are connected to mobile network: %@",[dict objectForKey:@"pdp_ip0/ipv4"]);
        return [dict objectForKey:@"pdp_ip0/ipv4"];
    }
    return @"error";
}

- (NSString *)getIPAddress:(BOOL)preferIPv4{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

- (NSDictionary *)getIPAddresses{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnSave:(id)sender{
    
    if([self.tbName.text isEqualToString:@""] || [self.tbTo.text isEqualToString:@""] || [self.tbFrom.text isEqualToString:@""] || [self.tbHours.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else
    {
        NSMutableDictionary *dic = [[arrayLocations objectAtIndex:self.viewCountry.selectedItemIndex] mutableCopy];
        
        NSString *strName = self.tbName.text;
        NSString *strAddress = [dic objectForKey:@"address"];
        NSString *strLocationId = [dic objectForKey:@"rand_id"];
        NSString *strTO = self.tbTo.text;
        NSString *strFrom = self.tbFrom.text;
        NSString *strDay = self.viewDays.items[self.viewDays.selectedItemIndex];
        NSString *strLocationName = self.viewCountry.items[self.viewCountry.selectedItemIndex];
        NSString *ipAddress = [self getIPAddress]; //Only get on Device.
        NSString *strHours = self.tbHours.text;

        [SVProgressHUD showWithStatus:@"Please wait..."];

        [objServerDataHandler createSchedule:strName address:strAddress location_id:strLocationId to:strTO from:strFrom day:strDay ip_address:ipAddress hours:strHours];
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
    if (typeID == kResponseGetCompanyLocationList) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayLocations=[[NSMutableArray alloc]init];
            arrayLocations=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            arrayLocationName = [[NSMutableArray alloc]init];
            
            for (NSMutableDictionary *dic in arrayLocations) {
                [arrayLocationName addObject:[dic objectForKey:@"name"]];
            }
            
            self.viewCountry.items = [NSArray arrayWithArray:arrayLocationName];
            self.viewCountry.selectedItemIndex = 0;
        }
    }
    if(typeID == kResponseCreateSchedule)
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
