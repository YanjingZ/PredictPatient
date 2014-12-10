//  ViewController.m
//  learning
//
//  Created by Anali Sakhala on 11/27/14.
//  Copyright (c) 2014 Anali Sakhala. All rights reserved.
//

#import "ViewController.h"
#import "CalendarDayEventViewController.h"
#import "AddEventViewController.h"
#import "RemoteWebViewController.h"


@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)addEvent:(id)sender {
    AddEventViewController *remoteViewCOntroller = [[AddEventViewController alloc] init];
    [self.navigationController pushViewController:remoteViewCOntroller animated:YES];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:remoteViewCOntroller];
    
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"the thing finished presenting");
    }];

}
- (IBAction)appointment:(id)sender {
    CalendarDayEventViewController *remoteViewCOntroller = [[CalendarDayEventViewController alloc] init];
    [self.navigationController pushViewController:remoteViewCOntroller animated:YES];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:remoteViewCOntroller];
    
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"the thing finished presenting");
    }];

}
- (IBAction)whereIsThePatient:(id)sender {
    RemoteWebViewController *remoteViewCOntroller = [[RemoteWebViewController alloc] init];
    [self.navigationController pushViewController:remoteViewCOntroller animated:YES];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:remoteViewCOntroller];
    
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"the thing finished presenting");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
