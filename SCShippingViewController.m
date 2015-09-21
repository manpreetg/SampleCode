//
//  SCShippingViewController.m
//  SCM App
//
//  Created by NetSet on 8/14/15.
//  Copyright (c) 2015 SAI-Dine. All rights reserved.
//

#import "SCShippingViewController.h"

@interface SCShippingViewController ()

@end

@implementation SCShippingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Shipping";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate & Data Sources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier    = @"Cell";
    UITableViewCell *cell                     = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    UITextField *entryTxtFld        = (UITextField*)[cell.contentView viewWithTag:79];
    entryTxtFld.delegate            = self;
    CALayer *TopBorder              = [CALayer layer];
    TopBorder.frame                 = CGRectMake(0.0f, entryTxtFld.frame.size.height-1, entryTxtFld.frame.size.width, 1.0f);
    TopBorder.backgroundColor       = [UIColor lightGrayColor].CGColor;
    [entryTxtFld.layer addSublayer:TopBorder];
    entryTxtFld.placeholder         = [@[@"PO Number",@"Item Number",@"NSN",@"Units",@"Item Name",@"Location"]objectAtIndex:indexPath.row];
    UIImageView *userTFLeftView     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 55)];
    userTFLeftView.contentMode      = UIViewContentModeCenter;
    userTFLeftView.image            = [UIImage imageNamed:[@[@"po_nmber",@"item_number",@"watch",@"unit",@"item_name",@"location"]objectAtIndex:indexPath.row]];
    userTFLeftView.backgroundColor  = [UIColor clearColor];
    entryTxtFld.leftViewMode        = UITextFieldViewModeAlways;
    entryTxtFld.leftView            = userTFLeftView;
    UITextField *barcodeTxtFld      = (UITextField*)[cell.contentView viewWithTag:80];
    
    if (indexPath.row==0) {
        barcodeTxtFld.hidden            = NO;
        UIImageView *userTFLeftView     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 55)];
        userTFLeftView.contentMode      = UIViewContentModeCenter;
        userTFLeftView.image            = [UIImage imageNamed:@"barcode"];
        userTFLeftView.backgroundColor  = [UIColor clearColor];
        barcodeTxtFld.leftViewMode      = UITextFieldViewModeAlways;
        barcodeTxtFld.leftView          = userTFLeftView;
        barcodeTxtFld.delegate          = self;
    }
    else {
        barcodeTxtFld.hidden            = YES;
    }
    
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    return 100.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(tableView.frame), 100)];
    headerView.backgroundColor      = [UIColor whiteColor];
    UIImageView *topImageView       = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(tableView.frame)-10, 90)];
    topImageView.clipsToBounds      = YES;
    topImageView.layer.cornerRadius = 2.0;
    topImageView.image              = [UIImage imageNamed:@"headerBack"];
    
    
    [headerView addSubview:topImageView];
    return headerView;
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==80) {
        [self performSegueWithIdentifier:@"scanBarCodeSegue" sender:nil];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
