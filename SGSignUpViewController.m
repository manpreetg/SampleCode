//
//  RegisterScreen.m
//  SampleCode
//
//  Created by NetSet on 9/21/15.
//  Copyright (c) 2015 NetSet. All rights reserved.
//

#import "RegisterScreen.h"

@interface RegisterScreen (){
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation RegisterScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTextFieldIdentation];
    activityIndicator=[[UIActivityIndicatorView alloc]init];
    
    
    //// keyboard hide notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- navigation bar customization
-(void)setNavigationBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"PTSans-Regular" size:18.0]}];
    //// create the back button with the image for the naviagtion bar
    UIButton *backbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    //    [backbutton setImage:[UIImage irmageNamed:@"top-arrow"] forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [backbutton setBackgroundImage:[UIImage imageNamed:@"back-iPad"] forState:UIControlStateNormal];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"PTSans-Regular" size:22.0]}];
    }
    else{
        [backbutton setBackgroundImage:[UIImage imageNamed:@"top-arrow"] forState:UIControlStateNormal];
    }
    [backbutton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backbarButton=[[UIBarButtonItem alloc]initWithCustomView:backbutton];
    self.navigationItem.leftBarButtonItem=backbarButton;
}
#pragma mark- textfield identation setting
-(void)setTextFieldIdentation
{
    /*********** set identation of the textviews ********************/
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UITextField class]]) {
            
            
            //// round the corners of the textfield
            view.layer.cornerRadius=5.0f;
            
            
            //// add left view with a colored view, and an image view with specified image according to the textfield
            UITextField *textFld = (UITextField*)view;
            UIView *spacerView;
            UIView *coloredView;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                spacerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, view.frame.size.height)];
                coloredView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 75, view.frame.size.height)];
                
            }
            else{
                spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, view.frame.size.height)];
                coloredView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, view.frame.size.height)];
                
            }
            
            [coloredView setBackgroundColor:APP_MAIN_COLOR];
            [spacerView addSubview:coloredView];
            [textFld setLeftViewMode:UITextFieldViewModeAlways];
            [textFld setLeftView:spacerView];
            
        }
        else if ([view isKindOfClass:[UIButton class]]){
            view.layer.cornerRadius=5.0f;
        }
    }
}
#pragma mark- hide keyboard notification
-(void)hideKeyboard:(NSNotification *)notification{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame=self.view.frame;
        frame.origin.y=0;
        self.view.frame=frame;
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromSignIn"]) {
        LoginScreen *loginObj=segue.destinationViewController;
        loginObj.isComingFromRegisterScreen=YES;
    }
}


#pragma mark- text filed delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag>=3) {
        if (self.view.frame.origin.y!=-150) {
            [UIView animateWithDuration:0.3f animations:^{
                CGRect frame=self.view.frame;
                frame.origin.y=-150;
                self.view.frame=frame;
            }];
            
        }
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //// move the control to the next texfield
    
    NSInteger tag=textField.tag+1;
    
    UIResponder *responder=[textField.superview viewWithTag:tag];
    if(responder)
    {
        [responder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        [[self view]endEditing:YES];
    }
    
    return NO;
}
#pragma mark- alert view delegates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self performSegueWithIdentifier:@"signIn" sender:self];
}
#pragma mark- touches began
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark- button actions
-(void)backButtonAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)createAccountAction:(id)sender {
    [self.view endEditing:YES];
    NSString  *firstName=[self.firstNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *lastName=[self.lastnameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *emailAddress=[self.emailAddressTextField .text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *userName=[self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString  *password=[self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmPassword=[self.confirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if([self validateFieldsWithFirstName:firstName lastName:lastName email:emailAddress userName:userName confirmPassword:confirmPassword andPassword:password]){
        [self registerUserWithFirstName:firstName lastName:lastName email:emailAddress userName:userName andPassword:password deviceToken:PCHDeviceToken withSender:sender];
    }
    // [self performSegueWithIdentifier:@"signIn" sender:self];
}
- (IBAction)logInNowAction:(id)sender {
    [self.view endEditing:YES];
    if (self.isComingFromLoginScreen) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self performSegueWithIdentifier:@"fromSignIn" sender:self];
    }
}
#pragma mark- validations
-(BOOL)validateFieldsWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)emailAddress userName:(NSString *)username confirmPassword:(NSString *)confirmPassword andPassword:(NSString *)password{
    NSString *emailRegEx = @"[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    if (firstName.length==0||lastName.length==0||emailAddress.length==0||username.length==0||password.length==0) {
        [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:@"All fields are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return NO;
    }
    else if ([emailTest evaluateWithObject:emailAddress] != YES && [emailAddress length]!=0){
        [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:@"Please enter a valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return NO;
    }
    else if ([username containsString:@" "]){
        [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:@"Username cannot contain blank spaces" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return NO;
    }
    else if ([username rangeOfCharacterFromSet:set].location != NSNotFound){
        [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:@"Username cannot contain special characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return NO;
    }
    else if (![confirmPassword isEqualToString:password]){
        [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:@"Passwords do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return NO;
    }
    
    return YES;
}
#pragma mark- webservice method
-(void)registerUserWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)emailAddress userName:(NSString *)username andPassword:(NSString *)password deviceToken:(NSString *)deviceToken withSender:(id)sender{
    
    
    [self shouldShowIndicatorOnSender:sender Value:YES];
    
    NSDictionary *paramDictionary=@{@"first_name":firstName,@"last_name":lastName,@"email":emailAddress,@"username":username,@"password":password,@"device_id":deviceToken,@"device_type":@"IOS"};
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:WEBSERVICE_URL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"register" parameters:paramDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"true"]) {
            PCHUserID=[NSString stringWithFormat:@"%@",[responseObject valueForKeyPath:@"user_id.id"]];
            [[NSUserDefaults standardUserDefaults] setValue:PCHUserID forKey:@"userId"];
            
            
            [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:@"Sign up successfull!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            
            
            
        }
        else{
            [[[UIAlertView alloc]initWithTitle:@"Sign Up" message:[responseObject objectForKey:@"Message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        }
        [self shouldShowIndicatorOnSender:sender Value:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc]initWithTitle:@"Sign In" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        [self shouldShowIndicatorOnSender:sender Value:NO];
    }];
    
}
#pragma mark- show indicator on view
-(void)shouldShowIndicatorOnSender:(id)sender Value:(BOOL)value{
    
    
    UIButton *sendingButton=(UIButton *)sender;
    if (value) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
            [activityIndicator setFrame:CGRectMake(sendingButton.frame.size.width-50 , sendingButton.frame.size.height/2-10, 20, 20)];
        }
        else{
            activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
            [activityIndicator setFrame:CGRectMake(sendingButton.frame.size.width-30, sendingButton.frame.size.height/2-10, 20, 20)];
        }
        
        [activityIndicator startAnimating ];
        activityIndicator.hidesWhenStopped=YES;
        
        [sendingButton addSubview:activityIndicator];
        [self.view setUserInteractionEnabled:NO];
    }
    else{
        [self.view setUserInteractionEnabled:YES];
        [activityIndicator stopAnimating];
    }
}
@end