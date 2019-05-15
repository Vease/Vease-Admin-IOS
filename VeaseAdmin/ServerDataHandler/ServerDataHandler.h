//
//  ServerDataHandler.h
//

// Live on FreeQuranEducation Server
#define kBaseMainURL @"http://www.sharjeelkhan.ca/vease/vease-app/api/v1/"
#define kBaseImageURl @"http://sharjeelkhan.ca/vease/vease-app/application-file/img/"

#define kBaseUserLogin @"company-login"
#define kBaseCompanyRegister @"company-register"
#define kBaseLeadPage @"order-company"
#define kBaseResolutionCenter @"resolution-center"
#define kBaseRescheduleRequest @"reschedule-request"
#define kBaseRequestAllServices @"service"
#define kBaseCompanyStaff @"company-staff"
#define kBaseCompanyTaxList @"company-tax-list"
#define kBaseStaffRoles @"staff-roles"
#define kBaseGetBundles @"bundle"
#define kBaseGetServicesById @"location-service"
#define kBaseAddShift @"company-shifts"
#define kBaseGetShifts @"company-shifts"
#define kBaseGetCompanyLocation @"company-location"
#define kBaseGetCompanySchedule @"company-schedule"
#define kBaseCreateSchedule @"company-schedule"
#define kBaseGetCompanyLocationList @"company-location-list"
#define kBaseCreateCompanyTax @"company-tax"
#define kBaseGetServices @"service"
#define kBaseAddNewServices @"service"
#define kBaseCategoryList @"category-list"
#define kBaseGetSubCategory @"subcategory"
#define kBaseDeleteStaffRoles @"staff-roles"
#define kBaseGetCompanyDetail @"company-detail"
#define kBaseUpdateCompanyProfile @"company-profile"

#import <Foundation/Foundation.h>
@protocol ServerDataHandlerDelegate <NSObject>

-(void)serverDidLoadDataSuccessfully :(NSDictionary *)responce;
-(void)serverDidFail :(NSError *)error;

@end

@interface ServerDataHandler : NSObject

typedef enum ResponseType{
    kResponseUserLogin = 1,
    kResponseRegisterCompany = 2,
    kResponseLeadPage = 3,
    kResponseResolutionCenter = 4,
    kResponseRescheduleReques = 5,
    kResponseRequestAllServices = 6,
    kResponseCompanyStaff = 7,
    kResponseCompanyTaxList = 8,
    kResponiseStaffRoles = 9,
    kResponseGetBundles = 10,
    kResponseAddBundles = 11,
    kResponseGetServicesById = 12,
    kResponseAddShift = 13,
    kResponseGetShifts = 14,
    kResponseGetCompanyLocation = 15,
    kResponseGetCompanySchedule = 16,
    kResponseCreateSchedule = 17,
    kResponseGetCompanyLocationList = 18,
    kResponseCreateCompanyTax = 19,
    kResponseGetServices = 20,
    kResponseAddNewServices = 21,
    kResponseGetCategoryList = 22,
    kResponseGetSubCategory = 23,
    kResponseDeleteStaffRoles = 24,
    kResponseGetCompanyDetail = 25,
    kResponseUpdateCompanyProfile = 26,
 
}ResponseType;

@property (strong , nonatomic) id<ServerDataHandlerDelegate> delegate;

-(BOOL)userLogin:(NSString *)email password:(NSString *)password;

-(BOOL)registerCompany:(NSString *)name email:(NSString *)email password:(NSString *)password c_password:(NSString *)c_password;

-(BOOL)leadPage;

-(BOOL)resolutionCenter;

-(BOOL)rescheduleReques;

-(BOOL)requestAllServices;

-(BOOL)companyStaff;

-(BOOL)companyTaxList;

-(BOOL)getStaffRoles;

-(BOOL)getBundles;

-(BOOL)addBundles:(NSString *)name description:(NSString *)description;

-(BOOL)getServicesById;

-(BOOL)addShift:(NSString *)name unpaid_break:(NSString *)unpaid_break schedule_id:(NSString *)schedule_id to:(NSString *)to from:(NSString *)from notes:(NSString *)notes position:(NSString *)position;

-(BOOL)getShifts;

-(BOOL)GetCompanyLocation;

-(BOOL)GetCompanySchedule;

-(BOOL)createSchedule:(NSString *)name address:(NSString *)address location_id:(NSString *)location_id to:(NSString *)to from:(NSString *)from day:(NSString *)day ip_address:(NSString *)ip_address hours:(NSString *)hours;

-(BOOL)getCompanyLocationList;

-(BOOL)createCompanyTax:(NSString *)name percentage:(NSString *)percentage jurisdiction:(NSString *)jurisdiction description:(NSString *)description dumpy_input:(NSString *)dumpy_input;

-(BOOL)getServices;

-(BOOL)addNewServices:(NSString *)name details:(NSString *)details category_id:(NSString *)category_id subcategory_id:(NSString *)subcategory_id price:(NSString *)price publish:(NSString *)publish status:(NSString *)status frequency:(NSString *)frequency currency:(NSString *)currency video_links:(NSString *)video_links company_id:(NSString *)company_id company_location_id:(NSString *)company_location_id;

-(BOOL)getCategoryList;

-(BOOL)getSubCategory:(NSString *)category_id;

-(BOOL)deleteStaffRoles:(NSString *)role_id;

-(BOOL)GetCompanyDetail;

-(BOOL)UpdateCompanyProfile:(NSString *)name state:(NSString *)state time_zone:(NSString *)time_zone city:(NSString *)city domain_name:(NSString *)domain_name address:(NSString *)address phone:(NSString *)phone country:(NSString *)country image:(NSString *)image;

@end

