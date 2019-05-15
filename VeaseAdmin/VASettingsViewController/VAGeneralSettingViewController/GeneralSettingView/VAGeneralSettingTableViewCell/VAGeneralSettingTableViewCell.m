//
//  VAGeneralSettingTableViewCell.m
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAGeneralSettingTableViewCell.h"

@implementation VAGeneralSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.viewSource.layer.masksToBounds = NO;
//    self.viewSource.layer.borderWidth=2.0;
//    self.viewSource.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
//    self.viewSource.layer.cornerRadius=5.0;
//    self.viewSource.items = @[@"(GMT-12:00) International Date Line West", @"(GMT-13:00) midway Island, Samoa", @"(GMT-10:00) Hawaii",@"(GMT-9:00) Alaska"];
//        self.viewSource.selectedItemIndex = 0;
//        [self.viewSource setBackgroundColor:[UIColor whiteColor]];
//    
//    self.viewCountry.layer.masksToBounds = NO;
//    self.viewCountry.layer.borderWidth=2.0;
//    self.viewCountry.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
//    self.viewCountry.layer.cornerRadius=5.0;
//    self.viewCountry.items = @[@"USA", @"Pakistan", @"India",@"Russia",@"Saudia Arabia",@"UAE"];
//    self.viewCountry.selectedItemIndex = 0;
//    [self.viewCountry setBackgroundColor:[UIColor whiteColor]];
//    
//    self.btnUpdate.layer.cornerRadius=10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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


@end
