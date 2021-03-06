//
//  LoginTableViewController.m
//  VoluteeRide
//
//  Created by Karim Abdul on 11/15/15.
//  Copyright © 2015 Karim Abdul. All rights reserved.
//

#import "LoginTableViewController.h"

static NSString *loginCellIdentifierUsername = @"Username";
static NSString *loginCellIdentifierPassword = @"Password";
static NSString *loginCellIdentifierSubmit = @"Submit";
static NSString *loginCellIdentifierRegistration = @"Registration";

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 2;
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
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    
    NSInteger section = [indexPath section];
    
    
    switch (section) {
        case 0:
            if (indexPath.row == 0) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:loginCellIdentifierUsername];
                
                if(!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:loginCellIdentifierUsername];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if (indexPath.row == 1) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:loginCellIdentifierPassword];
                
                if(!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:loginCellIdentifierPassword];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            break;
            
        case 1:
            if (indexPath.row == 0) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:loginCellIdentifierSubmit];
                
                if(!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:loginCellIdentifierSubmit];
                }
            }
            
            break;
        
        case 2:
            if (indexPath.row == 0) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:loginCellIdentifierRegistration];
                
                if(!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:loginCellIdentifierRegistration];
                }
            }
            
            break;
            
        default:
            break;
    }
    
    // Configure the cell...
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Login";
            break;
        case 1:
            //sectionName = @"Not Registered?";
            break;
        case 2:
            sectionName = @"Not Registered?";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    NSLog(@"%li",(long)indexPath.row);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y - 10);
    scrollPoint = [self.tableView convertPoint:scrollPoint fromView:textField.superview];
    [self.tableView setContentOffset:scrollPoint animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
