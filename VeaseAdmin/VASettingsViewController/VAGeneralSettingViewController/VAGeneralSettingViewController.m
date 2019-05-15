//
//  VAGeneralSettingViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAGeneralSettingViewController.h"

#define tabBarMargenFromTop 61

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface VAGeneralSettingViewController ()
{
    NSMutableArray *arrayCategory;
    TPKeyboardAvoidingScrollView *coverView;
    NSMutableArray *arrayCompanyShifts;
    UIActivityIndicatorView *spinner;
    NSMutableArray *arrayCompanyLocations;
    NSMutableArray *arrayCompanySchedules;
    NSString *strProfileImagePath;
}

@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerView *pageView;

@property(strong,nonnull)IBOutlet UITableView *infoTableView;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;
@property(strong,nonnull)IBOutlet UITableView *locationTableView;
@property(strong,nonnull)IBOutlet UITableView *scheduleTableView;
@property(strong,nonnull)IBOutlet UITableView *shiftsTableView;

@end

@implementation VAGeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
//    [super addMainTopViewWithMenu];
//    [self.revealViewController tapGestureRecognizer];
    [self setupView];
    
    arrayCategory=[[NSMutableArray alloc]initWithObjects:@"INFO",@"LOCATION",@"SCHEDULE",@"SHIFTS", nil];
    
    [self addPagerTabBar];
    [self addPagerView];
    [self reloadData];
    [self getCompanyDetail];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setMenuAnimationView];
    
    if(self.tabBar.curIndex == 1)
    {
        [self getCompanyLocation];
    }
    if(self.tabBar.curIndex == 2)
    {
        [self getCompanySchedule];
    }
    if(self.tabBar.curIndex == 3)
    {
        [self getCompanyShifts];
    }
    
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
    self.lblHeading.text=@"Settings";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getCompanyShifts{
    //[SVProgressHUD showWithStatus:@"Please wait..."];
    [spinner setHidden:NO];
    [spinner startAnimating];
    [objServerDataHandler getShifts];
}

-(void)getCompanyLocation{
    [spinner setHidden:NO];
    [spinner startAnimating];
    [objServerDataHandler GetCompanyLocation];
}

-(void)getCompanySchedule{
    [spinner setHidden:NO];
    [spinner startAnimating];
    [objServerDataHandler GetCompanySchedule];
}

-(void)getCompanyDetail{
    [spinner setHidden:NO];
    [spinner startAnimating];
    [objServerDataHandler GetCompanyDetail];
}

-(void)goToVANewScheduleViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    VANewScheduleViewController *objVANewScheduleViewController= (VANewScheduleViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VANewScheduleViewController"];
    [self.navigationController pushViewController:objVANewScheduleViewController animated:YES];
}

-(void)goToVAAddShiftViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    VAAddShiftViewController *objVAAddShiftViewController= (VAAddShiftViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAAddShiftViewController"];
    [self.navigationController pushViewController:objVAAddShiftViewController animated:YES];
}

-(void)upDateInfoView{
    self.viewSource.layer.masksToBounds = NO;
    self.viewSource.layer.borderWidth=2.0;
    self.viewSource.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewSource.layer.cornerRadius=5.0;
    self.viewSource.items = @[@"(GMT-12:00) International Date Line West", @"(GMT-13:00) midway Island, Samoa", @"(GMT-10:00) Hawaii",@"(GMT-9:00) Alaska"];
    self.viewSource.selectedItemIndex = 0;
    [self.viewSource setBackgroundColor:[UIColor whiteColor]];
    
    self.viewCountry.layer.masksToBounds = NO;
    self.viewCountry.layer.borderWidth=2.0;
    self.viewCountry.layer.borderColor=[self colorWithHexString:@"30C75D"].CGColor;
    self.viewCountry.layer.cornerRadius=5.0;
    self.viewCountry.items = @[@"USA", @"Pakistan", @"India",@"Russia",@"Saudia Arabia",@"UAE"];
    self.viewCountry.selectedItemIndex = 0;
    [self.viewCountry setBackgroundColor:[UIColor whiteColor]];
    
    self.btnUpdate.layer.cornerRadius=10.0;
    
    UserDC *objUserDc=[[UserDC alloc]init];
    objUserDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
    
    self.tbCompanyName.text = objUserDc.user_name;
    //self.viewSource
    self.tbProvince.text = objUserDc.state;
    self.tbCity.text = objUserDc.city;
    self.tbDomainName.text = objUserDc.domain_name;
    self.tbAddress.text = objUserDc.address;
    self.tbPhone.text = objUserDc.phone;
    // self.viewCountry
    
    if(objUserDc.image){
        NSString *strImgUrl=[NSString stringWithFormat:@"%@%@",kBaseImageURl,objUserDc.image];
        [self.imgViewProfile sd_setImageWithURL:[NSURL URLWithString:strImgUrl]];
        self.imgViewProfile.layer.masksToBounds = NO;
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.frame.size.width/2;
        self.imgViewProfile.clipsToBounds = YES;
    }
    
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
}

-(IBAction)onBtnUpdate:(id)sender{
    
    
    NSString *strName = self.tbCompanyName.text;
    NSString *strState = self.tbProvince.text;
    NSString *strTimeZone = self.viewSource.items[self.viewSource.selectedItemIndex];
    NSString *strCity = self.tbCity.text;
    NSString *strDomainName = self.tbDomainName.text;
    NSString *strAddress = self.tbAddress.text;
    NSString *strPhone = self.tbPhone.text;
    NSString *strCountry = self.viewCountry.items[self.viewCountry.selectedItemIndex];
    NSString *imgPath = strProfileImagePath;
    
    
    
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler UpdateCompanyProfile:@"" state:@"" time_zone:@"" city:@"" domain_name:@"" address:@"" phone:@"" country:@"" image:@""];
    
    
    
}

-(IBAction)onBtnUpdateImage:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attach image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* pickFromGallery =
    [UIAlertAction actionWithTitle:@"Take Picture"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                                   UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                   picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                   picker.delegate = self;
                                   [self presentViewController:picker animated:YES completion:NULL];
                               }
                               
                           }];
    UIAlertAction* takeAPicture =
    [UIAlertAction actionWithTitle:@"Pick from Library"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                               picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                               picker.delegate = self;
                               [self presentViewController:picker animated:YES completion:NULL];
                           }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                   }];
    
    [alertController addAction:pickFromGallery];
    [alertController addAction:takeAPicture];
    [alertController addAction:cancel];
    
    //For set action sheet to middle of view.
    CGRect rect = self.view.frame;
    rect.origin.x = self.view.frame.size.width / 20;
    rect.origin.y = self.view.frame.size.height / 20;
    alertController.popoverPresentationController.sourceView = self.view;
    alertController.popoverPresentationController.sourceRect = rect;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- Custome Views

-(void)addNewLoacation{
    [_plusButtonsViewMain hideButtonsAnimated:YES completionHandler:nil];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    coverView=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:window.frame];
    coverView.backgroundColor =
    [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    coverView.tag=1000;
    
    UIView * customPopUp;
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAAddNewLocation" owner:self options:nil];
    customPopUp =[subviewArray objectAtIndex:0];
    customPopUp.frame=self.view.frame;
    customPopUp.backgroundColor=[UIColor clearColor];
    
    customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
    
    UIView *viewBackgroundView=(UIView *)[customPopUp viewWithTag:100];
    viewBackgroundView.layer.masksToBounds = NO;
    viewBackgroundView.layer.cornerRadius=5.0;
    
    UIButton *btnCancel=(UIButton *)[customPopUp viewWithTag:102];
    [btnCancel addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnBuy=(UIButton *)[customPopUp viewWithTag:103];
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
                                    if(self.tabBar.curIndex==1)
                                    {
                                        //Add New Location
                                        [self addNewLoacation];
                                    }
                                    if(self.tabBar.curIndex==2)
                                    {
                                        //Add New Schedule
                                        [self goToVANewScheduleViewController];
                                    }
                                    if(self.tabBar.curIndex==3)
                                    {
                                        [self goToVAAddShiftViewController];
                                    }
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

#pragma mark -- Pager View Methods

- (void)addPagerTabBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.dataSource = self;
    tabBar.delegate = self;
    tabBar.backgroundColor=[self colorWithHexString:@"2A2C3A"];
    tabBar.layout.selectedTextColor=[self colorWithHexString:@"30C75D"];
    tabBar.layout.normalTextColor=[UIColor whiteColor];
    tabBar.layout.cellWidth=self.view.frame.size.width/4-10;
    tabBar.layout.progressColor=[self colorWithHexString:@"30C75D"];
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)addPagerView {
    TYPagerView *pageView = [[TYPagerView alloc]init];
    //pageView.layout.progressAnimateEnabel = NO;
    //pageView.layout.prefetchItemCount = 1;
    pageView.layout.autoMemoryCache = NO;
    pageView.dataSource = self;
    pageView.delegate = self;
    // you can rigsiter cell like tableView
    [pageView.layout registerClass:[UIView class] forItemWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pageView];
    _pageView = pageView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //CGRectGetMaxY(self.navigationController.navigationBar.frame)
    _tabBar.frame = CGRectMake(0, tabBarMargenFromTop,CGRectGetWidth(self.view.bounds), 45);
    _pageView.frame = CGRectMake(0, CGRectGetMaxY(_tabBar.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
}

- (void)reloadData {
    [_tabBar reloadData];
    [_pageView reloadData];
}

#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return arrayCategory.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = arrayCategory[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = arrayCategory[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pageView scrollToViewAtIndex:index animate:YES];
    
    if(index == 1)
    {
        [self getCompanyLocation];
    }
    if(index == 2)
    {
        [self getCompanySchedule];
    }
    if(index == 3)
    {
        [self getCompanyShifts];
    }
}

#pragma mark - TYPagerViewDataSource

- (NSInteger)numberOfViewsInPagerView {
    return arrayCategory.count;
}

- (UIView *)pagerView:(TYPagerView *)pagerView viewForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    //you can set UIView *view = [[UIView alloc]initWithFrame:[pagerView.layout frameForItemAtIndex:index]]; or UIView *view = [[UIView alloc]init];
    //or reigster and dequeue item like tableView
    
    if(index==0)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"GeneralSettingView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.infoTableView=(UITableView *)[customPopUp viewWithTag:101];
        [self.infoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.infoTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.infoTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.infoTableView.backgroundColor=[UIColor clearColor];
        
        return customPopUp;
    }
    else if(index==1)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralLocationView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.locationTableView=(UITableView *)[customPopUp viewWithTag:101];
        [self.locationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.locationTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.locationTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.locationTableView.backgroundColor=[UIColor clearColor];
        
        spinner = (UIActivityIndicatorView *)[customPopUp viewWithTag:102];
        [spinner setHidden:YES];
        
        return customPopUp;
    }
    else if(index==2)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralLocationView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.scheduleTableView=(UITableView *)[customPopUp viewWithTag:101];
        [self.scheduleTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.scheduleTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.scheduleTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.scheduleTableView.backgroundColor=[UIColor clearColor];
        
        spinner = (UIActivityIndicatorView *)[customPopUp viewWithTag:102];
        [spinner setHidden:YES];
        
        return customPopUp;
    }
    else if(index==3)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralLocationView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.shiftsTableView=(UITableView *)[customPopUp viewWithTag:101];
        [self.shiftsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.shiftsTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.shiftsTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.shiftsTableView.backgroundColor=[UIColor clearColor];
        
        spinner = (UIActivityIndicatorView *)[customPopUp viewWithTag:102];
        [spinner setHidden:YES];
        
        return customPopUp;
    }
    else
    {
        UIView *view = [pagerView.layout dequeueReusableItemWithReuseIdentifier:@"cellId" forIndex:index];
        view.backgroundColor = [self colorWithHexString:@"EBEBEB"];
        return view;
    }
}

#pragma mark - TYPagerViewDelegate

- (void)pagerView:(TYPagerView *)pagerView willAppearView:(UIView *)view forIndex:(NSInteger)index {
    //NSLog(@"+++++++++willAppearViewIndex:%ld",index);
    
    if(index==0)
    {
        [self.plusButtonsViewMain setHidden:YES];
    }
    else
    {
        [self.plusButtonsViewMain setHidden:NO];
    }
}

- (void)pagerView:(TYPagerView *)pagerView willDisappearView:(UIView *)view forIndex:(NSInteger)index {
    //NSLog(@"---------willDisappearView:%ld",index);
}

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    NSLog(@"fromIndex:%ld, toIndex:%ld",fromIndex,toIndex);
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    //NSLog(@"fromIndex:%ld, toIndex:%ld progress%.3f",fromIndex,toIndex,progress);
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)pagerViewWillBeginScrolling:(TYPagerView *)pageView animate:(BOOL)animate {
    //NSLog(@"pagerViewWillBeginScrolling");
}

- (void)pagerViewDidEndScrolling:(TYPagerView *)pageView animate:(BOOL)animate {
    //NSLog(@"pagerViewDidEndScrolling");
    if(pageView.curIndex == 0)
    {
        [self upDateInfoView];
    }
    if(pageView.curIndex == 1)
    {
        [self getCompanyLocation];
    }
    if(pageView.curIndex == 2)
    {
        [self getCompanySchedule];
    }
    if(pageView.curIndex == 3)
    {
        [self getCompanyShifts];
    }
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
    if(tableView==self.infoTableView)
    {
        return 1;
    }
    if(tableView==self.locationTableView)
    {
        return [arrayCompanyLocations count];
    }
    if(tableView==self.scheduleTableView)
    {
        return [arrayCompanySchedules count];
    }
    if(tableView==self.shiftsTableView)
    {
        return [arrayCompanyShifts count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"infoCell";
    static NSString *MyIdentifier1 = @"locationCell";
    static NSString *MyIdentifier2 = @"shiftsCell";
    
    if(tableView==self.infoTableView)
    {
        VAGeneralSettingTableViewCell *cell = (VAGeneralSettingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralSettingTableViewCell"
                                                owner:self
                                              options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        UIView *viewBackground = (UIView *)[cell viewWithTag:100];
        viewBackground.layer.masksToBounds = NO;
        viewBackground.layer.cornerRadius = 5.f;
        
        self.tbCompanyName = (ACFloatingTextField *)[cell viewWithTag:101];
        self.viewSource = (TPSDropDown *)[cell viewWithTag:102];
        self.tbProvince = (ACFloatingTextField *)[cell viewWithTag:103];
        self.tbCity = (ACFloatingTextField *)[cell viewWithTag:104];
        self.tbDomainName = (ACFloatingTextField *)[cell viewWithTag:105];
        self.tbAddress = (ACFloatingTextField *)[cell viewWithTag:106];
        self.viewCountry = (TPSDropDown *)[cell viewWithTag:107];
        self.tbPhone = (ACFloatingTextField *)[cell viewWithTag:108];
        self.btnUpdate = (UIButton *)[cell viewWithTag:109];
        [self.btnUpdate addTarget:self action:@selector(onBtnUpdate:) forControlEvents:UIControlEventTouchUpInside];
        self.imgViewProfile =(UIImageView *)[cell viewWithTag:110];
        self.btnUpdateImage = (UIButton *)[cell viewWithTag:111];
        [self.btnUpdateImage addTarget:self action:@selector(onBtnUpdateImage:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == self.locationTableView)
    {
        VAGeneralLocationTableViewCell *cell = (VAGeneralLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier1];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralLocationTableViewCell"
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
        
        NSMutableDictionary *dic = [arrayCompanyLocations objectAtIndex:indexPath.row];
        
        cell.lblLocationName.text = [dic objectForKey:@"name"];
        cell.lblLocationAddress.text = [dic objectForKey:@"address"];
        
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == self.scheduleTableView)
    {
        VAGeneralLocationTableViewCell *cell = (VAGeneralLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier1];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralLocationTableViewCell"
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
        
        NSMutableDictionary *dic = [arrayCompanySchedules objectAtIndex:indexPath.row];
        
        cell.lblLocationName.text = [dic objectForKey:@"name"];
        cell.lblLocationAddress.text = [dic objectForKey:@"address"];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == self.shiftsTableView)
    {
        VAGeneralLocationTableViewCell *cell = (VAGeneralLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier2];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAGeneralLocationTableViewCell"
                                                owner:self
                                              options:nil];
            cell = [nib objectAtIndex:1];
        }
        
        UIView *viewBackground = (UIView *)[cell viewWithTag:100];
        viewBackground.layer.shadowRadius  = 1.5f;
        viewBackground.layer.shadowColor   = [UIColor grayColor].CGColor;
        viewBackground.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
        viewBackground.layer.shadowOpacity = 0.9f;
        viewBackground.layer.masksToBounds = NO;
        
        NSMutableDictionary *dic = [arrayCompanyShifts objectAtIndex:indexPath.row];
        
        cell.lblShiftName.text = [dic objectForKey:@"name"];
        cell.lblShiftPosition.text = [dic objectForKey:@"position"];
        cell.lblShiftTo.text = [dic objectForKey:@"to"];
        cell.lblShiftFrom.text = [dic objectForKey:@"from"];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.infoTableView)
    {
        return 800;
    }
    if(tableView==self.locationTableView)
    {
        return 65;
    }
    if(tableView==self.scheduleTableView)
    {
        return 65;
    }
    if(tableView==self.shiftsTableView)
    {
        return 65;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark-- UIImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *imageName=@"";
    NSString *strImagePath=@"";
    
    if ([picker sourceType] == UIImagePickerControllerSourceTypeCamera) {
        // Do something with an image from the camera
        
        imageName = [NSString stringWithFormat:@"%@.PNG",[NSString stringWithFormat:@"%@",[[[info objectForKey:@"UIImagePickerControllerMediaMetadata"]objectForKey:@"{Exif}"]objectForKey:@"DateTimeOriginal"]]];
    } else {
        // Do something with an image from another source
        NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerImageURL"];
        imageName = [imagePath lastPathComponent];
    }
    
    UIImage *imagePicked = info[UIImagePickerControllerOriginalImage];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    strImagePath = [documentsDirectory stringByAppendingPathComponent:
                    imageName];
    NSData* data = UIImagePNGRepresentation(imagePicked);
    [data writeToFile:strImagePath atomically:YES];
    self.imgViewProfile.image = imagePicked;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(imagePicked, nil, nil, nil);
    }
    
    strProfileImagePath=strImagePath;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- ServerData handler classes

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseGetShifts) {
        NSLog(@"Response is %@",responce);
        [spinner stopAnimating];
        [spinner setHidden:YES];
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayCompanyShifts=[[NSMutableArray alloc]init];
            arrayCompanyShifts=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            NSLog(@"Data array %@",arrayCompanyShifts);
            
            self.shiftsTableView.delegate=self;
            self.shiftsTableView.dataSource=self;
            [self.shiftsTableView reloadData];
        }
    }
    if (typeID == kResponseGetCompanyLocation) {
        NSLog(@"Response is %@",responce);
        [spinner stopAnimating];
        [spinner setHidden:YES];
        if([[responce objectForKey:@"responceData"] objectForKey:@"data"] && [[responce objectForKey:@"responceData"] objectForKey:@"data"]!= [NSNull class] && [[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayCompanyLocations=[[NSMutableArray alloc]init];
            arrayCompanyLocations=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            NSLog(@"Data array %@",arrayCompanyLocations);
            
            self.locationTableView.delegate=self;
            self.locationTableView.dataSource=self;
            [self.locationTableView reloadData];
        }
    }
    if (typeID == kResponseGetCompanySchedule) {
        NSLog(@"Response is %@",responce);
        [spinner stopAnimating];
        [spinner setHidden:YES];
        if([[responce objectForKey:@"responceData"] objectForKey:@"data"] && [[responce objectForKey:@"responceData"] objectForKey:@"data"]!= [NSNull class] && [[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayCompanySchedules=[[NSMutableArray alloc]init];
            arrayCompanySchedules=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            NSLog(@"Data array %@",arrayCompanySchedules);
            
            self.scheduleTableView.delegate=self;
            self.scheduleTableView.dataSource=self;
            [self.scheduleTableView reloadData];
        }
    }
    if(typeID == kResponseGetCompanyDetail){
        NSLog(@"Response is %@",responce);
        [spinner stopAnimating];
        [spinner setHidden:YES];
        
        if([[responce objectForKey:@"responceData"] objectForKey:@"data"] && [[responce objectForKey:@"responceData"] objectForKey:@"data"]!= [NSNull class] && [[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            NSMutableDictionary *dic =[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            UserDC *userDc=[[UserDC alloc]init];
            userDc=[[VAGlobalInstance getInstance]loadCustomObjectWithKey:@"userInfo"];
            
            userDc.address =[dic objectForKey:@"address"];
            userDc.city =[dic objectForKey:@"city"];
            userDc.country =[dic objectForKey:@"country"];
            userDc.created_at =[dic objectForKey:@"created_at"];
            userDc.domain_name =[dic objectForKey:@"domain_name"];
            userDc.c_id =[dic objectForKey:@"id"];
            userDc.image =[dic objectForKey:@"image"];
            userDc.phone =[dic objectForKey:@"phone"];
            userDc.rand_id =[dic objectForKey:@"rand_id"];
            userDc.state =[dic objectForKey:@"state"];
            userDc.time_zone =[dic objectForKey:@"time_zone"];
            userDc.updated_at =[dic objectForKey:@"updated_at"];
            userDc.user_name =[[responce objectForKey:@"responceData"] objectForKey:@"user"];
            
            [[VAGlobalInstance getInstance] saveCustomObject:userDc key:@"userInfo"];
            
            [self upDateInfoView];
            
        }
    }
    
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}

@end
