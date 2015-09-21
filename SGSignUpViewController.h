//
//  RegisterScreen.h
//  SampleCode
//
//  Created by NetSet on 9/21/15.
//  Copyright (c) 2015 NetSet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginScreen.h"


@interface RegisterScreen : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UIButton *createAccountButton;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)createAccountAction:(id)sender;
- (IBAction)logInNowAction:(id)sender;
@property (nonatomic) BOOL isComingFromLoginScreen;

@end
