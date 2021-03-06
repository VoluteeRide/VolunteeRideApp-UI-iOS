//
//  RegistrationViewController.m
//  VoluteeRide
//
//  Created by Karim Abdul on 11/22/15.
//  Copyright © 2015 Karim Abdul. All rights reserved.
//

//Custom Controller & Views Import
#import "RegistrationViewController.h"
#import "JKRegistrationTableViewCell.h"
#import "MBProgressHUD.h"

// Requestor Import
#import "VRRequestor.h"

//Data Model Import
#import "JKCenterLocation.h"
#import "Registration.h"
#import "OwnedVehicles.h"

//Personal Info Identifiers
static NSString *registrationCellIdentifierUsername = @"Username";
static NSString *registrationCellIdentifierPassword = @"Password";
static NSString *registrationCellIdentifierFirstname = @"Firstname";
static NSString *registrationCellIdentifierLastname = @"Lastname";
static NSString *registrationCellIdentifierEmail = @"Email";
static NSString *registrationCellIdentifierPhoneNumber = @"PhoneNumber";

//Vehicle Info Identifiers
static NSString *registrationCellIdentifierMake = @"Make";
static NSString *registrationCellIdentifierModel = @"Model";
static NSString *registrationCellIdentifierCapacity = @"Capacity";
static NSString *registrationCellIdentifierType = @"Type";
static NSString *registrationCellIdentifierColor = @"Color";

//Jamat Khana Location Idenfifier
static NSString *registrationCellIdentifierJKLocation = @"JKLocation";

//Registration Identifier
static NSString *registrationCellIdentifierRegister = @"Register";

@interface RegistrationViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *userSegmentControl;
@property (nonatomic, strong) NSArray *centerLocations;
@property (nonatomic, strong) UIPickerView *centerLocationsPickerView;
@property (nonatomic, assign) CGRect tableViewRect;
@property (nonatomic, strong) Registration *userRegistration;
@property (nonatomic, strong) OwnedVehicles *userOwnedVehicle;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) JKCenterLocation *selectedJKLocation;
@property (nonatomic, strong) UITextField *jkLocationTextField;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Registration";
    
    self.centerLocations = [NSArray array];
    
//    UIColor *backgroundColor = [self.tableView backgroundColor];
//    
//    [self.view setBackgroundColor:backgroundColor];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(-55.0f, 0.0f, 0.0f, 0.0f);
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableViewRect = self.tableView.frame;
    
    [self requestJKLocations];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.userSegmentControl.selectedSegmentIndex == 0) {
        return 3;
    } else if (self.userSegmentControl.selectedSegmentIndex == 1 || self.userSegmentControl.selectedSegmentIndex == 2) {
        return 4;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.userSegmentControl.selectedSegmentIndex == 0) {
        switch (section) {
            case 0:
                return 6;
                break;
            case 1:
                return 1;
                break;
            case 2:
                return 1;
                break;
            default:
                return 0;
                break;
                
        }
    } else if (self.userSegmentControl.selectedSegmentIndex == 1 || self.userSegmentControl.selectedSegmentIndex == 2) {
        switch (section) {
            case 0:
                return 6;
                break;
            case 1:
                return 5;
                break;
            case 2:
                return 1;
                break;
            case 3:
                return 1;
                break;
            default:
                return 0;
                break;
                
        }

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JKRegistrationTableViewCell *cell;
    cell.tag = indexPath.row;
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    if (self.userSegmentControl.selectedSegmentIndex == 0) {
        if (section == 0) {
            
            switch (row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierUsername];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierUsername];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.centerLocationTextField.delegate = self;
                    break;
                    
                case 1:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierPassword];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierPassword];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 2:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierFirstname];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierFirstname];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 3:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierLastname];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierLastname];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 4:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierEmail];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierEmail];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 5:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierPhoneNumber];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierPhoneNumber];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                default:
                    break;
            }
        }
        
        else if (section == 1) {
            
            switch (row) {
                case 0: {
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierJKLocation];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierJKLocation];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.centerLocationTextField.inputView = self.centerLocationsPickerView;
                    cell.centerLocationTextField.inputAccessoryView = self.toolBar;
                    self.jkLocationTextField = cell.centerLocationTextField;
                    
                    break;
                }
                    
                default:
                    break;
            }
        }
        else if (section == 2) {
            
            switch (row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierRegister];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierRegister];
                    }
                    break;
                    
                default:
                    break;
            }
        }

    }
    
    else if (self.userSegmentControl.selectedSegmentIndex == 1 || self.userSegmentControl.selectedSegmentIndex == 2) {
        
        
        if (section == 0) {
            
            switch (row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierUsername];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierUsername];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 1:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierPassword];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierPassword];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 2:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierFirstname];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierFirstname];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 3:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierLastname];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierLastname];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 4:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierEmail];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierEmail];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 5:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierPhoneNumber];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierPhoneNumber];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                default:
                    break;
            }
        }
        
        else if (section == 1) {
            
            switch (row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierMake];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierMake];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 1:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierModel];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierModel];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 2:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierCapacity];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierCapacity];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 3:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierType];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierType];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                case 4:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierColor];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierColor];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    break;
                    
                default:
                    break;
            }
        }
    
        else if (section == 2) {
            
            switch (row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierJKLocation];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierJKLocation];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.centerLocationTextField.inputView = self.centerLocationsPickerView;
                    self.jkLocationTextField = cell.centerLocationTextField;
                
                    break;
                    
                default:
                    break;
            }

        }
    
        else if (section == 3) {
            
            switch (row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:registrationCellIdentifierRegister];
                    
                    if(!cell) {
                        cell = [[JKRegistrationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:registrationCellIdentifierRegister];
                    }
                    break;
                    
                default:
                    break;
            }
            
        }
    }
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *sectionName = @"";
    
    if (self.userSegmentControl.selectedSegmentIndex == 0) {
        switch (section)
        {
            case 0:
                sectionName = @"Personal Information";
                break;
            case 1:
                sectionName = @"Choose Jamat Khana Location";
                break;
            default:
                sectionName = @"";
                break;
        }

    } else if (self.userSegmentControl.selectedSegmentIndex == 1 || self.userSegmentControl.selectedSegmentIndex == 2) {
        switch (section)
        {
            case 0:
                sectionName = @"Personal Information";
                break;
            case 1:
                sectionName = @"Vehicle Information";
                break;
            case 2:
                sectionName = @"Choose Jamat Khana Location";
                break;
            default:
                sectionName = @"";
                break;
        }
    }
    
    return sectionName;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)userSegmentedControlndexChanged:(id)sender {
    [self.tableView reloadData];
}

- (void)requestJKLocations {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    
    __weak RegistrationViewController *weakSelf = self;
    VRRequestor *vrRequestor = [VRRequestor sharedInstance];
    [vrRequestor getJKLocations:^(AFHTTPRequestOperation *op, id resp) {
       
         [hud hide:YES];;
        
        if ([resp isKindOfClass:[NSArray class]]) {
            [weakSelf setJKCenterLocations:resp];
        }
        
    }];
}

- (void)setJKCenterLocations:(NSArray*)locations {
    
    NSMutableArray *jkLocations = [[NSMutableArray alloc] initWithCapacity:[locations count]];
    
    
    for (int i = 0; i<[locations count]; i++) {
        JKCenterLocation *centerLocation = [[JKCenterLocation alloc] initWithDictionary:[locations objectAtIndex:i]];
        [jkLocations addObject:centerLocation];
    }
    
    self.centerLocations = [jkLocations copy];
}

- (UIPickerView*)centerLocationsPickerView {
    
    if (!_centerLocationsPickerView) {
        _centerLocationsPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216.0)];
        [_centerLocationsPickerView setDataSource: self];
        [_centerLocationsPickerView setDelegate: self];
        _centerLocationsPickerView.showsSelectionIndicator = YES;
    }
    
    return _centerLocationsPickerView;
}

- (UIToolbar*)toolBar {
    
    if (!_toolBar) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,screenWidth,44)];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStylePlain target:self action:@selector(updateJkLocation:)];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

        barButtonDone.tintColor=[UIColor blueColor];
        _toolBar.items = @[flexSpace,barButtonDone];
    }
    return _toolBar;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.centerLocations count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    JKCenterLocation *jkLocation = (JKCenterLocation*)[self.centerLocations objectAtIndex:row];
    return jkLocation.name;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    scrollPoint = [self.tableView convertPoint:scrollPoint fromView:textField.superview];
    [self.tableView setContentOffset:scrollPoint animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    
    if ([textField.placeholder isEqualToString:@"Phone Number"] && self.userSegmentControl.selectedSegmentIndex == 0) {
        [self jumpToNextTextField:textField withTag:100];
        return NO;
    }
    
    else if ([textField.placeholder isEqualToString:@"Color"] && self.userSegmentControl.selectedSegmentIndex == 1) {
        [self jumpToNextTextField:textField withTag:100];
        return NO;
    }

    
    NSInteger nextTag = textField.tag + 1;
    [self jumpToNextTextField:textField withTag:nextTag];
    return NO;
}

- (void)jumpToNextTextField:(UITextField *)textField withTag:(NSInteger)tag {
    
    // Gets the next responder from the view. Here we use self.view because we are searching for controls with
    // a specific tag, which are not subviews of a specific views, because each textfield belongs to the
    // content view of a static table cell.
    //
    // In other cases may be more convenient to use textField.superView, if all textField belong to the same view.
    UIResponder *nextResponder = [self.view viewWithTag:tag];
    
    if ([nextResponder isKindOfClass:[UITextField class]]) {
        // If there is a next responder and it is a textfield, then it becomes first responder.
        [nextResponder becomeFirstResponder];
    }
    else {
        // If there is not then removes the keyboard.
        [textField resignFirstResponder];
    }
}

- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
    //[self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    NSLog(@"%li",(long)indexPath.row);
    NSLog(@"%li",(long)indexPath.section);
    
    if ((indexPath.section == 2 && indexPath.row == 0) || (indexPath.section == 3 && indexPath.row == 0)) {
        [self setUserRoles];
        [self setUserOwnedVehicle];
        [self registerUser];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
}

#pragma mark - Lazy Loading

- (Registration*)userRegistration {
    
    if (!_userRegistration) {
        _userRegistration = [[Registration alloc] init];
    }
    return _userRegistration;
}

- (OwnedVehicles*)userOwnedVehicle {
    
    if (!_userOwnedVehicle) {
        _userOwnedVehicle = [[OwnedVehicles alloc] init];
    }
    return _userOwnedVehicle;
}

#pragma mark - Mapping Model

- (IBAction)editingChanged:(id)sender {
    
    UITextField *textField = (UITextField*)sender;
    
    switch (textField.tag) {
        case 1:
            self.userRegistration.username = textField.text;
            break;
        case 2:
            self.userRegistration.password = textField.text;
            break;
        case 3:
            self.userRegistration.firstName = textField.text;
            break;
        case 4:
            self.userRegistration.lastName = textField.text;
            break;
        case 5:
            self.userRegistration.email = textField.text;
            break;
        case 6:
            self.userRegistration.phone = textField.text;
            break;
        case 7:
            self.userOwnedVehicle.make = textField.text;
            break;
        case 8:
            self.userOwnedVehicle.model = textField.text;
            break;
        case 9:
            self.userOwnedVehicle.totalRiderCapacity = [textField.text doubleValue];
            break;
        case 10:
            self.userOwnedVehicle.type = textField.text;
            break;
        case 11:
            self.userOwnedVehicle.color = textField.text;
            break;

        default:
            break;
    }
}

- (void)setUserRoles {
    
    //Set User Roles
    NSMutableArray *userRoles = [[NSMutableArray alloc] init];
    NSString *userRoleRideSeeker = [NSString new];
    NSString *userRoleVolunteer = [NSString new];
    
    if (self.userSegmentControl.selectedSegmentIndex == 0) {
        userRoleRideSeeker = @"RIDE_SEEKER";
        [userRoles addObject:userRoleRideSeeker];
    } else if (self.userSegmentControl.selectedSegmentIndex == 1) {
        userRoleVolunteer = @"VOLUNTEER";
        [userRoles addObject:userRoleVolunteer];
    } else if (self.userSegmentControl.selectedSegmentIndex == 2) {
        userRoleRideSeeker = @"RIDE_SEEKER";
        userRoleVolunteer = @"VOLUNTEER";
        [userRoles addObject:userRoleRideSeeker];
        [userRoles addObject:userRoleVolunteer];
    }
    
    self.userRegistration.userRoles = userRoles;
}

- (void)setUserOwnedVehicle {
    
    //Set User Vehicle
    
    if (self.userSegmentControl.selectedSegmentIndex == 0) {
        self.userRegistration.ownedVehicles = nil;
    } else {

        NSMutableArray *userOwnedVehicle = [[NSMutableArray alloc] init];
        [userOwnedVehicle addObject:self.userOwnedVehicle];
        
        self.userRegistration.ownedVehicles = userOwnedVehicle;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%li",(long)row);
    self.selectedRow = row;
    
    //[self updateJkLocation:pickerView];
}


- (void)updateJkLocation:(id)sender {
    
    [self.view endEditing:YES];

    self.selectedJKLocation = [self.centerLocations objectAtIndex:[self.centerLocationsPickerView selectedRowInComponent:self.selectedRow]];
    self.userRegistration.centerId = self.selectedJKLocation.centerLocationIdentifier;
    
    if (self.jkLocationTextField) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.jkLocationTextField.text = self.selectedJKLocation.name;
        });
    }
}

- (void)registerUser {
    NSDictionary *registerUser = [self.userRegistration dictionaryRepresentation];
    NSLog(@"%@",registerUser);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    
    __weak RegistrationViewController *weakSelf = self;
    VRRequestor *vrRequestor = [VRRequestor sharedInstance];
    [vrRequestor registerUser:registerUser completed:^(AFHTTPRequestOperation *op, id resp) {
        
        [hud hide:YES];;
        
        NSLog(@"%@",resp);
        if ([resp isKindOfClass:[NSError class]]) {
//            NSError *error = (NSError*)resp;
//            NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",ErrorResponse);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)op.response;
            NSLog(@"status code: %li", (long)httpResponse.statusCode);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)op.response;
            NSLog(@"status code: %li", (long)httpResponse.statusCode);
        }
        
    }];


}

@end
