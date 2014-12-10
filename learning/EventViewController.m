//
//  EventViewController.m
//  learning
//
//  Created by Anali Sakhala on 11/30/14.
//  Copyright (c) 2014 Anali Sakhala. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Day View", @"");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"+ Event "
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(dismiss)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void) dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Aaaaaaand...it's gone.");
    }];
    
}
- (IBAction)addEvent:(id)sender {

    NSLog(@"hey..");
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
