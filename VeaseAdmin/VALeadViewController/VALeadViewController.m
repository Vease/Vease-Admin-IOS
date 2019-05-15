//
//  VALeadViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 23/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VALeadViewController.h"

#define tabBarMargenFromTop 70

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface VALeadViewController ()
{
    NSMutableArray *arrayCategory;
    NSMutableArray *arrayData;
    NSMutableArray *arrayPending;
    NSMutableArray *arraySchedule;
    NSMutableArray *arrayCompleted;
    NSMutableArray *arrayReSchedule;
}

@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerView *pageView;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;

@end

@implementation VALeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    objServerDataHandler = [[ServerDataHandler alloc] init];
    objServerDataHandler.delegate = self;
    
    [super addMainTopViewWithMenu];
    [self.revealViewController tapGestureRecognizer];
    
     arrayCategory=[[NSMutableArray alloc]initWithObjects:@"PENDING",@"SCHEDULE",@"COMPLETED",@"RESCHDULE", nil];
    
    [self addPagerTabBar];
    [self addPagerView];
    [self reloadData];
    
    [self getDataFromServer];
    
    [self.pendingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.pendingTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.pendingTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.pendingTableView.backgroundColor=[UIColor clearColor];
    
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

-(void)goToAddLeadViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    VAAddLeadViewController *objVAAddLeadViewController= (VAAddLeadViewController *)[storyboard instantiateViewControllerWithIdentifier:@"VAAddLeadViewController"];
    [self.navigationController pushViewController:objVAAddLeadViewController animated:YES];
}

-(void)getDataFromServer{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [objServerDataHandler leadPage];
}

-(NSString *)getFormatedDate:(NSString *)postedDate{
    NSString *strFormatedDate = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date  = [dateFormatter dateFromString:postedDate];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    strFormatedDate = [dateFormatter stringFromDate:date];
    
    
    return [NSString stringWithFormat:@"%@",strFormatedDate];
}

-(NSString *)getFormatedTime:(NSString *)postedDate{
    NSString *strFormatedDate = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date  = [dateFormatter dateFromString:postedDate];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"HH:mm"];
    strFormatedDate = [dateFormatter stringFromDate:date];
    
    
    return [NSString stringWithFormat:@"%@",strFormatedDate];
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
                                    [self goToAddLeadViewController];
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
    tabBar.layout.selectedTextColor=[UIColor blackColor];
    tabBar.layout.normalTextColor=[UIColor grayColor];
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
    _tabBar.frame = CGRectMake(0, tabBarMargenFromTop,CGRectGetWidth(self.view.bounds), 36);
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
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VALeadPendingView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-160);
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.pendingTableView=(UITableView *)[customPopUp viewWithTag:101];
        [self.pendingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.pendingTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.pendingTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.pendingTableView.backgroundColor=[UIColor clearColor];
        
//        [self.pendingTableView.layer setCornerRadius:10.0];
//        [self.pendingTableView setClipsToBounds:YES];
        
        self.pendingTableView.dataSource=self;
        self.pendingTableView.delegate=self;
        
        customPopUp.backgroundColor = [UIColor clearColor];
        return customPopUp;
    }
    else if(index == 2)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VALeadPendingView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-160);
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.completedTablView=(UITableView *)[customPopUp viewWithTag:101];
        [self.completedTablView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.completedTablView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.completedTablView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.completedTablView.backgroundColor=[UIColor clearColor];

        
        self.completedTablView.dataSource=self;
        self.completedTablView.delegate=self;
        
        customPopUp.backgroundColor = [UIColor clearColor];
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
        [self.plusButtonsViewMain setHidden:NO];
    }
    else
    {
        [self.plusButtonsViewMain setHidden:YES];
    }
}

- (void)pagerView:(TYPagerView *)pagerView willDisappearView:(UIView *)view forIndex:(NSInteger)index {
    //NSLog(@"---------willDisappearView:%ld",index);
}

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    NSLog(@"fromIndex:%ld, toIndex:%ld",(long)fromIndex,toIndex);
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
}

#pragma mark--UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView == self.pendingTableView)
    {
        return [arrayPending count];
    }
    if(tableView == self.completedTablView)
    {
        return [arrayCompleted count];
    }
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
    
    if(tableView == self.pendingTableView)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VALeadingPendingTableSectionView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame = CGRectMake(0, 0, self.pendingTableView.frame.size.width, 62);
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        NSMutableDictionary *dicData=[[arrayPending objectAtIndex:section] mutableCopy];
        
         UIView *viewSectionBackground = (UIView *)[customPopUp viewWithTag:100];
        UILabel *lblname = (UILabel *)[customPopUp viewWithTag:101];
        lblname.text = [dicData objectForKey:@"customer_name"];
     
        return customPopUp;
        
    }
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view setBackgroundColor:[UIColor redColor]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   // return 52;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==self.pendingTableView)
    {
        return [[[arrayPending objectAtIndex:section] objectForKey:@"services"] count];
    }
    if(tableView == self.completedTablView)
    {
        return [[[arrayCompleted objectAtIndex:section] objectForKey:@"services"] count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"pendingCell";
    
    VALeadPendingTableViewCell *cell = (VALeadPendingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NSArray *nib;
    if (cell == nil) {
        nib = [[NSBundle mainBundle] loadNibNamed:@"VALeadPendingTableViewCell"
                                            owner:self
                                          options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    UIView *viewBackground = (UIView *)[cell viewWithTag:100];
//    viewBackground.layer.masksToBounds = NO;
//    viewBackground.layer.cornerRadius = 5.f;
    
    NSMutableDictionary *dicCompanyInf0 = [arrayPending objectAtIndex:indexPath.section];
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    if(tableView==self.pendingTableView)
    {
       array = [[arrayPending objectAtIndex:indexPath.section] objectForKey:@"services"];
    }
    if(tableView == self.completedTablView)
    {
         array = [[arrayCompleted objectAtIndex:indexPath.section] objectForKey:@"services"];
    }
   
    NSMutableDictionary *dic=[[array objectAtIndex:indexPath.row] mutableCopy];
    cell.lblname.text = [dicCompanyInf0 objectForKey:@"customer_name"];
    cell.lblPrice.text=[NSString stringWithFormat:@"$%@",[dic objectForKey:@"price"]];
    cell.lblDate.text = [self getFormatedDate:[dic objectForKey:@"updated_at"]];
    cell.lblTime.text =  [self getFormatedTime:[dic objectForKey:@"updated_at"]];
    cell.lblService.text = [dic objectForKey:@"name"];
    
    //cell.viewCellBack.layer.cornerRadius = 5.0f;
    cell.viewCellBack.layer.shadowRadius  = 1.5f;
    cell.viewCellBack.layer.shadowColor   = [UIColor grayColor].CGColor;
    cell.viewCellBack.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.viewCellBack.layer.shadowOpacity = 0.9f;
    cell.viewCellBack.layer.masksToBounds = NO;
    
    NSLog(@"array: %@",array);
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.pendingTableView || tableView == self.completedTablView)
    {
        return 120;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark--Service Database Methods

- (void)serverDidLoadDataSuccessfully:(NSDictionary *)responce {
    int typeID = [[responce objectForKeyedSubscript:@"Type"] intValue];
    [SVProgressHUD dismiss];
    if (typeID == kResponseLeadPage) {
        NSLog(@"Response is %@",responce);
        if([[[responce objectForKey:@"responceData"] objectForKey:@"data"] count]>0)
        {
            arrayData=[[NSMutableArray alloc]init];
            arrayData=[[responce objectForKey:@"responceData"] objectForKey:@"data"];
            
            arrayPending=[[NSMutableArray alloc]init];
            arraySchedule=[[NSMutableArray alloc]init];
            arrayCompleted=[[NSMutableArray alloc]init];
            arrayReSchedule=[[NSMutableArray alloc]init];
            
            NSLog(@"Data array %@",arrayData);
            
            for(NSMutableDictionary *dic in arrayData)
            {
                if([[dic objectForKey:@"order_stage"] intValue] == 1)
                {
                    [arrayPending addObject:dic];
                }
                if([[dic objectForKey:@"order_stage"] intValue] == 2)
                {
                    [arraySchedule addObject:dic];
                }
                if([[dic objectForKey:@"order_stage"] intValue] == 3)
                {
                   [arrayCompleted addObject:dic];
                }
               if([[dic objectForKey:@"order_stage"] intValue] == 4)
                {
                   [arrayReSchedule addObject:dic];
                }
            }
            
            NSLog(@"Col");
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pendingTableView.delegate=self;
                self.pendingTableView.dataSource=self;
                [self.pendingTableView reloadData];
            });
           
            
        }
    }
    
    
}

- (void)serverDidFail:(NSError *)error {
    [SVProgressHUD dismiss];
    NSLog(@"Error: %@",error.localizedDescription);
    [self showMessage:@"Vease" meeeage:error.localizedDescription];
}

@end
