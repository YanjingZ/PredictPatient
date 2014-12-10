//
//  AddEventViewController.m
//  learning
//
//  Created by Anali Sakhala on 11/30/14.
//  Copyright (c) 2014 Anali Sakhala. All rights reserved.
//

#import "AddEventViewController.h"
#import "Parse/Parse.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AddEventViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *patientName;
@property (strong, nonatomic) IBOutlet UITextField *patientEmail;
@property (strong, nonatomic) IBOutlet UITextField *desc;
-(void)keyboardDidShow:(NSNotification *) notification;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Day View", @"");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(dismiss)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    
}

-(void)keyboardDidShow:(NSNotification *) notification{
    [self.view setFrame:CGRectMake(0, -100, 320, 460)];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Aaaaaaand...it's gone.");
    }];
    
}
- (IBAction)addEvent:(id)sender {
    
    
    PFObject *appointment = [PFObject objectWithClassName:@"DocPatient"];
    PFObject *patientinfo = [PFObject objectWithClassName:@"Patients"];
    
    patientinfo[@"emailadd"]=self.patientEmail.text;
    patientinfo[@"name"]=self.patientName.text;
    
    appointment[@"doctorid"] = @"5afVBxNYEf";
    appointment[@"patientemail"] = self.patientEmail.text;
    appointment[@"patientname"] = self.patientName.text;
    appointment[@"description"] = self.desc.text;
    NSDate * d = [self.datePicker date];
    appointment[@"timeofapp"]=d;
    [appointment saveInBackground];
    [patientinfo saveInBackground];

    NSLog(@"done saving ");    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
