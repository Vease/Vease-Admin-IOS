//
//  VAFinanceSettingViewController.m
//  VeaseAdmin
//
//  Created by aliapple on 28/11/2018.
//  Copyright © 2018 aliapple. All rights reserved.
//

#import "VAFinanceSettingViewController.h"

#define tabBarMargenFromTop 61

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface VAFinanceSettingViewController ()
{
    NSMutableArray *arrayCategory;
}

@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerView *pageView;

@end


@implementation VAFinanceSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self setupView];
    
    arrayCategory=[[NSMutableArray alloc]initWithObjects:@"GENERAL",@"INVOICES", nil];
    
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
    self.lblHeading.text=@"Finance";
    [self.btnMenu addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- IBAction Methods

-(IBAction)onBtnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onBtnCurrenceSelectedBefore:(id)sender{
    
    self.imgCurrenceSelectedBefore.image = [UIImage imageNamed:@"ic_radioSelected"];
    self.imgCurrenceSelectedAfter.image = [UIImage imageNamed:@"ic_radioUnSelected"];
}

-(IBAction)onBtnCurrenceSelectedAfter:(id)sender{
    self.imgCurrenceSelectedBefore.image = [UIImage imageNamed:@"ic_radioUnSelected"];
    self.imgCurrenceSelectedAfter.image = [UIImage imageNamed:@"ic_radioSelected"];
}

-(IBAction)onBtnTaxPerItemYes:(id)sender{
    self.imgTaxPerItemYes.image = [UIImage imageNamed:@"ic_radioSelected"];
    self.imgTaxPerItemNO.image = [UIImage imageNamed:@"ic_radioUnSelected"];
}

-(IBAction)onBtnTaxPerItemNO:(id)sender{
    self.imgTaxPerItemYes.image = [UIImage imageNamed:@"ic_radioUnSelected"];
    self.imgTaxPerItemNO.image = [UIImage imageNamed:@"ic_radioSelected"];
}

-(IBAction)onBtnSave:(id)sender{
}

-(IBAction)onBtnInvoiceYes:(id)sender{
    self.imgInvoiceYes.image = [UIImage imageNamed:@"ic_radioSelected"];
    self.imgInvoiceNO.image = [UIImage imageNamed:@"ic_radioUnSelected"];
}

-(IBAction)onBtnInvoiceNO:(id)sender{
    self.imgInvoiceYes.image = [UIImage imageNamed:@"ic_radioUnSelected"];
    self.imgInvoiceNO.image = [UIImage imageNamed:@"ic_radioSelected"];
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
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAFinanceGeneralView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:0];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        UIView *viewBack=(UIView *)[customPopUp viewWithTag:100];
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.borderWidth=2.0;
        viewBack.layer.borderColor=[self colorWithHexString:@"2A2C3A"].CGColor;
        viewBack.layer.cornerRadius=5.0;
        
        self.viewDecemalSeprator=(TPSDropDown *)[customPopUp viewWithTag:102];
        self.viewDecemalSeprator.items = @[@".", @"_", @"|",@"||",@"'",@"-"];
        self.viewDecemalSeprator.selectedItemIndex = 0;
        [self.viewDecemalSeprator setBackgroundColor:[UIColor whiteColor]];
        
        self.viewThousandSeprartor=(TPSDropDown *)[customPopUp viewWithTag:103];
        self.viewThousandSeprartor.items = @[@".", @"_", @"|",@"||",@"'",@"-"];
        self.viewThousandSeprartor.selectedItemIndex = 0;
        [self.viewThousandSeprartor setBackgroundColor:[UIColor whiteColor]];
        
        self.imgCurrenceSelectedBefore =(UIImageView *)[customPopUp viewWithTag:104];
        
        self.btnCurrenceSelectedBefore = (UIButton *)[customPopUp viewWithTag:105];
        [self.btnCurrenceSelectedBefore addTarget:self action:@selector(onBtnCurrenceSelectedBefore:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgCurrenceSelectedAfter =(UIImageView *)[customPopUp viewWithTag:106];
        
        self.btnCurrenceSelectedAfter = (UIButton *)[customPopUp viewWithTag:107];
        [self.btnCurrenceSelectedAfter addTarget:self action:@selector(onBtnCurrenceSelectedAfter:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgTaxPerItemYes =(UIImageView *)[customPopUp viewWithTag:108];
        
        self.btnTaxPerItemYes = (UIButton *)[customPopUp viewWithTag:109];
        [self.btnTaxPerItemYes addTarget:self action:@selector(onBtnTaxPerItemYes:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgTaxPerItemNO =(UIImageView *)[customPopUp viewWithTag:110];
        
        self.btnTaxPerItemNO = (UIButton *)[customPopUp viewWithTag:111];
        [self.btnTaxPerItemNO addTarget:self action:@selector(onBtnTaxPerItemNO:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tbDefaultTax=(ACFloatingTextField *)[customPopUp viewWithTag:112];
        
        self.btnSave = (UIButton *)[customPopUp viewWithTag:101];
        [self.btnSave addTarget:self action:@selector(onBtnSave:) forControlEvents:UIControlEventTouchUpInside];
        self.btnSave.layer.masksToBounds = NO;
        self.btnSave.layer.cornerRadius=10.0;

        return customPopUp;
    }
    else if(index==1)
    {
        UIView * customPopUp;
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VAFinanceGeneralView" owner:self options:nil];
        customPopUp =[subviewArray objectAtIndex:1];
        customPopUp.frame=self.view.frame;
        customPopUp.center=CGPointMake(customPopUp.center.x, customPopUp.center.y);
        
        UIView *viewBack=(UIView *)[customPopUp viewWithTag:100];
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.borderWidth=2.0;
        viewBack.layer.borderColor=[self colorWithHexString:@"2A2C3A"].CGColor;
        viewBack.layer.cornerRadius=5.0;
        
        self.viewInvoiceNumberPrefix=(TPSDropDown *)[customPopUp viewWithTag:101];
        self.viewInvoiceNumberPrefix.items = @[@"INV", @"ENV", @"ABC",@"INVC",@"IC",@"I"];
        self.viewInvoiceNumberPrefix.selectedItemIndex = 0;
        [self.viewInvoiceNumberPrefix setBackgroundColor:[UIColor whiteColor]];
        
        self.viewInvoiceNumber=(TPSDropDown *)[customPopUp viewWithTag:102];
        self.viewInvoiceNumber.items = @[@"1", @"2", @"3",@"4",@"5",@"6"];
        self.viewInvoiceNumber.selectedItemIndex = 0;
        [self.viewInvoiceNumber setBackgroundColor:[UIColor whiteColor]];
        
        self.viewDueAfterDate=(TPSDropDown *)[customPopUp viewWithTag:103];
        self.viewDueAfterDate.items = @[@"30", @"20", @"15",@"10",@"5",@"1"];
        self.viewDueAfterDate.selectedItemIndex = 0;
        [self.viewDueAfterDate setBackgroundColor:[UIColor whiteColor]];
     
        self.imgInvoiceYes =(UIImageView *)[customPopUp viewWithTag:104];
        
        self.btnInvoiceYes = (UIButton *)[customPopUp viewWithTag:105];
        [self.btnInvoiceYes addTarget:self action:@selector(onBtnInvoiceYes:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgInvoiceNO =(UIImageView *)[customPopUp viewWithTag:106];
        
        self.btnInvoiceNO = (UIButton *)[customPopUp viewWithTag:107];
        [self.btnInvoiceNO addTarget:self action:@selector(onBtnInvoiceNO:) forControlEvents:UIControlEventTouchUpInside];
        
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

@end
