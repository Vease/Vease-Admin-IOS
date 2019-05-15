//
//  VABundlesSettingViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 29/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VABundlesSettingViewController.h"

@interface VABundlesSettingViewController ()
{
    TPKeyboardAvoidingScrollView *coverView;
    NSMutableArray *arrayData;
}

@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;
@property (strong, nonatomic) IBOutlet UITableView *bundlesTableView;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *tbName;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *tbDescription;

@end

@implementation VABundlesSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
    [self setupView];
    
    [self.bundlesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.bundlesTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.bundlesTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.bundlesTableView.backgroundColor=[UIColor clearColor];
    
    [self getDataFromServer];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setMenuAnimationView];
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
    self.lblHeading.text=@"Bundles";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getDataFromServer{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler getBundles];
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnCancel:(id)sender{
    TPKeyboardAvoidingScrollView *sub=(TPKeyboardAvoidingScrollView *)[coverView viewWithTag:100];
    [UIView transitionWithView:sub
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        self->coverView.alpha = 0.0;
                    }
                    completion:^(BOOL finished){
                        [self->coverView removeFromSuperview];
                    }];
}

-(IBAction)onBtnAdd:(id)sender{
    
    if([self.tbName.text isEqualToString:@""] || [self.tbDescription.text isEqualToString:@""])
    {
        [self showMessage:@"Vease" meeeage:@"Required field missing."];
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [objServerDataHandler addBundles:self.tbName.text description:self.tbDescription.text];
    }
}

#pragma mark -- Custome Views

-(void)addNewBundle{
    [_plusButtonsViewMain hideButtonsAnimated:YES completionHandler:nil];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    coverView=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:window.frame];
    coverView.backgroundColor =
    [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    coverView.tag=1000;
    
    UIView * customPopUp;
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAAddBundleView" owner:self options:nil];
    customPopUp =[subviewArray objectAtIndex:0];
    customPopUp.frame=self.view.frame;
    customPopUp.backgroundColor=[UIColor clearColor];
    
    customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
    
    UIView *viewBackgroundView=(UIView *)[customPopUp viewWithTag:100];
    viewBackgroundView.layer.masksToBounds = NO;
    viewBackgroundView.layer.cornerRadius=5.0;
    
    self.tbName = (ACFloatingTextField *)[customPopUp viewWithTag:101];
    self.tbDescription = (ACFloatingTextField *)[customPopUp viewWithTag:102];
    
    UIButton *btnCancel=(UIButton *)[customPopUp viewWithTag:103];
    [btnCancel addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnBuy=(UIButton *)[customPopUp viewWithTag:104];
    [btnBuy addTarget:self action:@selector(onBtnAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    coverView.alpha = 0.0;
    [coverView addSubview:customPopUp];
    [window addSubview:coverView];
    
    [UIView transitionWithView:coverView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self->coverView.alpha = 1.0;
                    }
                    completion:^(BOOL finished){
                        
                    }];
}

#pragma mark -- LGPlusButtonsView

-(void)setMenuAnimationView{
    [_plusButtonsViewMain removeFromSuperview];
    
    _plusButtonsViewMain = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:1 firstButtonIsPlusButton:YES
                                                                   showAfterInit:YES actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                            {
                                NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                                
                                if (index == 0)
                                {
                                    [self addNewBundle];
                                }
                                
                            }];
    
    //_plusButtonsViewMain.observedScrollView = self.view;
    _plusButtonsViewMain.coverColor = [UIColor colorWithWhite:1.f alpha:0.7];
    _plusButtonsViewMain.position = LGPlusButtonsViewPositionBottomRight;
    _plusButtonsViewMain.plusButtonAnimationType = LGPlusButtonAnimationTypeRotate;
    
    [_plusButtonsViewMain setButtonsTitles:@[@"+"] forState:UIControlStateNormal];
    [_plusButtonsViewMain setDescriptionsTexts:@[@""]];
    [_plusButtonsViewMain setButtonsImages:@[[NSNull new]]
                                  forState:UIControlStateNormal forOrientation:LGPlusButtonsViewOrientationAll];
    
    [_plusButtonsViewMain setButtonsAdjustsImageWhenHighlighted:NO];
    //    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f] forState:UIControlStateNormal];
    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor colorWithRed:0.2 green:0.6 blue:1.f alpha:1.f] forState:UIControlStateHighlighted];
    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor colorWithRed:0.2 green:0.6 blue:1.f alpha:1.f] forState:UIControlStateHighlighted|UIControlStateSelected];
    [_plusButtonsViewMain setButtonsSize:CGSizeMake(44.f, 44.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setButtonsLayerCornerRadius:44.f/2.f forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setButtonsTitleFont:[UIFont boldSystemFontOfSize:24.f] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
    [_plusButtonsViewMain setButtonsTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [_plusButtonsViewMain setButtonsLayerShadowOpacity:0.5];
    [_plusButtonsViewMain setButtonsLayerShadowRadius:3.f];
    [_plusButtonsViewMain setButtonsLayerShadowOffset:CGSizeMake(0.f, 2.f)];
    [_plusButtonsViewMain setButtonAtIndex:0 size:CGSizeMake(56.f, 56.f)
                            forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
    [_plusButtonsViewMain setButtonAtIndex:0 layerCornerRadius:56.f/2.f
                            forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
    [_plusButtonsViewMain setButtonAtIndex:0 titleFont:[UIFont systemFontOfSize:40.f]
                            forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
    [_plusButtonsViewMain setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -3.f) forOrientation:LGPlusButtonsViewOrientationAll];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [_plusButtonsViewMain setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -2.f) forOrientation:LGPlusButtonsViewOrientationLandscape];
        [_plusButtonsViewMain setButtonAtIndex:0 titleFont:[UIFont systemFontOfSize:32.f] forOrientation:LGPlusButtonsViewOrientationLandscape];
    }
    
    [self.view addSubview:_plusButtonsViewMain];
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
    return [arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"bundlesCell";
    
    VABundleTableViewCell *cell = (VABundleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NSArray *nib;
    if (cell == nil) {
        nib = [[NSBundle mainBundle] loadNibNamed:@"VABundleTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UIView *viewBackground = (UIView *)[cell viewWithTag:100];
    viewBackground.layer.shadowRadius  = 1.5f;
    viewBackground.layer.shadowColor   = [UIColor grayColor].CGColor;
    viewBackground.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    viewBackground.layer.shadowOpacity = 0.9f;
    viewBackground.layer.masksToBounds = NO;
    
    NSMutableDictionary *dic = [arrayData objectAtIndex:indexPath.row];
    
    cell.lblName.text = [dic objectForKey:@"name"];
    cell.lblDescription.text = [dic objectForKey:@"description"];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseGetBundles) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayData=[[NSMutableArray alloc]init];
            arrayData=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            self.bundlesTableView.delegate = self;
            self.bundlesTableView.dataSource = self;
            [self.bundlesTableView reloadData];
        }
    }
    if(typeID == kResponseAddBundles)
    {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"success"] isEqualToString:@"true"])
        {
            [self showMessage:@"Vease" meeeage:[[responce objectForKey:@"responceData"] objectForKey:@"data"]];
            
            [self->coverView removeFromSuperview];
            [self getDataFromServer];
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
