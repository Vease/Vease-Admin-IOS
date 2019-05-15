//
//  VAPaymentSettingViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 29/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAPaymentSettingViewController.h"

#define tabBarMargenFromTop 61
#define paypalAndCreditCardRowHeight 540
#define creditCardTableRowHeight 750
#define generalRowHeight 50

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface VAPaymentSettingViewController ()
{
    NSMutableArray *arrayCategory;
}

@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerView *pageView;

@end

@implementation VAPaymentSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self setupView];
    
//    arrayCategory=[[NSMutableArray alloc]initWithObjects:@"GENERAL",@"PAYPAL",@"CREDIT CARD",@"STRIPE", nil];
     arrayCategory=[[NSMutableArray alloc]initWithObjects:@"GENERAL",@"STRIPE", nil];
    
    [self addPagerTabBar];
    [self addPagerView];
    [self reloadData];
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
    self.lblHeading.text=@"Payment";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnPayInvoiceYes:(id)sender{
    self.imgPayInvoiceYes.image = [UIImage imageNamed:@"ic_radioSelected"];
    self.imgPayInvoiceNO.image = [UIImage imageNamed:@"ic_radioUnSelected"];
}

-(IBAction)onBtnPayInvoiceNO:(id)sender{
    self.imgPayInvoiceYes.image = [UIImage imageNamed:@"ic_radioUnSelected"];
    self.imgPayInvoiceNO.image = [UIImage imageNamed:@"ic_radioSelected"];
}

-(IBAction)onBtnAmountToPayYes:(id)sender{
    self.imgAmountToPayYes.image = [UIImage imageNamed:@"ic_radioSelected"];
    self.imgAmountToPayNO.image = [UIImage imageNamed:@"ic_radioUnSelected"];
}

-(IBAction)onBtnAmountToPayNO:(id)sender{
    self.imgAmountToPayYes.image = [UIImage imageNamed:@"ic_radioUnSelected"];
    self.imgAmountToPayNO.image = [UIImage imageNamed:@"ic_radioSelected"];
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
    tabBar.layout.cellWidth=self.view.frame.size.width/2-10;
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
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentGeneralView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        UIView *viewBack=(UIView *)[customPopUp viewWithTag:100];
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.borderWidth=2.0;
        viewBack.layer.borderColor=[self colorWithHexString:@"2A2C3A"].CGColor;
        viewBack.layer.cornerRadius=5.0;
        
        self.imgPayInvoiceYes =(UIImageView *)[customPopUp viewWithTag:101];
        
        self.btnPayInvoiceYes = (UIButton *)[customPopUp viewWithTag:102];
        [self.btnPayInvoiceYes addTarget:self action:@selector(onBtnPayInvoiceYes:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgPayInvoiceNO =(UIImageView *)[customPopUp viewWithTag:103];
        
        self.btnPayInvoiceNO = (UIButton *)[customPopUp viewWithTag:104];
        [self.btnPayInvoiceNO addTarget:self action:@selector(onBtnPayInvoiceNO:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgAmountToPayYes =(UIImageView *)[customPopUp viewWithTag:105];
        
        self.btnAmountToPayYes = (UIButton *)[customPopUp viewWithTag:106];
        [self.btnAmountToPayYes addTarget:self action:@selector(onBtnAmountToPayYes:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgAmountToPayNO =(UIImageView *)[customPopUp viewWithTag:107];
        
        self.btnAmountToPayNO = (UIButton *)[customPopUp viewWithTag:108];
        [self.btnAmountToPayNO addTarget:self action:@selector(onBtnAmountToPayNO:) forControlEvents:UIControlEventTouchUpInside];
        
        return customPopUp;
        
    }
    else if(index==100)
    {
        //PayPalCell
        
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentPaypalView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.paypalTableView=(UITableView *)[customPopUp viewWithTag:100];
        [self.paypalTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.paypalTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.paypalTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.paypalTableView.backgroundColor=[UIColor clearColor];
        
        return customPopUp;
    }
    else if(index==200)
    {
        //Credit Card
        
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentPaypalView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.creditCardTableView=(UITableView *)[customPopUp viewWithTag:100];
        [self.creditCardTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.creditCardTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.creditCardTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.creditCardTableView.backgroundColor=[UIColor clearColor];
        
        return customPopUp;
    }
    else if(index==1)
    {
        //Stripe
        
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentPaypalView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        self.stripeTableView=(UITableView *)[customPopUp viewWithTag:100];
        [self.stripeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.stripeTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.stripeTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        self.stripeTableView.backgroundColor=[UIColor clearColor];
        
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
    if(tableView==self.paypalTableView || tableView == self.stripeTableView || self.creditCardTableView)
    {
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"PayPalCell";
    static NSString *MyIdentifier1 = @"StripeCell";
    static NSString *MyIdentifier2 = @"CreditCardCell";
    
    if(tableView == self.paypalTableView)
    {
        VAPaymentPaypalTableViewCell *cell = (VAPaymentPaypalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentPaypalTableViewCell"
                                                owner:self
                                              options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == self.creditCardTableView)
    {
        VAPaymentPaypalTableViewCell *cell = (VAPaymentPaypalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier2];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentPaypalTableViewCell"
                                                owner:self
                                              options:nil];
            cell = [nib objectAtIndex:2];
        }
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == self.stripeTableView)
    {
        VAPaymentPaypalTableViewCell *cell = (VAPaymentPaypalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier1];
        NSArray *nib;
        if (cell == nil) {
            nib = [[NSBundle mainBundle] loadNibNamed:@"VAPaymentPaypalTableViewCell"
                                                owner:self
                                              options:nil];
            cell = [nib objectAtIndex:1];
        }
        
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.paypalTableView || tableView == self.stripeTableView)
    {
        return paypalAndCreditCardRowHeight;
    }
    else if(tableView == self.creditCardTableView)
    {
        return creditCardTableRowHeight;
    }
    
    return generalRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
