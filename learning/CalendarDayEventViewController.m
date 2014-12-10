//
//  CalendarDayEventViewController.m
//  learning
//
//  Created by Anali Sakhala on 11/27/14.
//  Copyright (c) 2014 Anali Sakhala. All rights reserved.
//

#import "CalendarDayEventViewController.h"
#import "AddEventViewController.h"
#import "Parse/Parse.h"

@interface CalendarDayEventViewController ()

@end

@implementation CalendarDayEventViewController

- (NSUInteger) supportedInterfaceOrientations{
    return  UIInterfaceOrientationMaskPortrait;
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}



- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Day View", @"");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(dismiss)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    PFQuery *query = [PFQuery queryWithClassName:@"DocPatient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            for(NSDictionary *ar in objects){
                NSString *name = ar[@"patientname"];
                NSString *desc = ar[@"description"];
                NSDate *date = ar[@"timeofapp"];
                NSDateFormatter * format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"MM"];
                NSString *month = [format stringFromDate:date];
                [format setDateFormat:@"dd"];
                NSString *day = [format stringFromDate:date];
                [format setDateFormat:@"hh"];
                NSString *startHour =[format stringFromDate:date];
                [format setDateFormat:@"mm"];
                NSString *startMin=[format stringFromDate:date];
                NSInteger endHourInt = [startHour intValue]+1;
                NSString *endHour = [@(endHourInt) stringValue];
                NSArray * temp = [NSArray arrayWithObjects: desc,name,startHour,startMin,endHour,startMin,@"2014",month,day, nil];
                if (!self.data) self.data = [[NSMutableArray alloc] init];
                [self.data addObject:temp];

            }
           
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
   }


- (void) dismiss{
        [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Aaaaaaand...it's gone.");
    }];
     
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hairlineDividerView.hidden = YES;
    self.dayView.daysBackgroundView.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hairlineDividerView.hidden = NO;
    
}

#pragma mark TKCalendarDayViewDelegate
- (NSArray *) calendarDayTimelineView:(TKCalendarDayView*)calendarDayTimeline eventsForDate:(NSDate *)eventDate{
    
    
    
    if([eventDate compare:[NSDate dateWithTimeIntervalSinceNow:-24*60*60]] == NSOrderedAscending) return @[];
    if([eventDate compare:[NSDate dateWithTimeIntervalSinceNow:24*60*60]] == NSOrderedDescending) return @[];
    
    NSDateComponents *info = [[NSDate date] dateComponentsWithTimeZone:calendarDayTimeline.calendar.timeZone];
    info.second = 0;
    NSMutableArray *ret = [NSMutableArray array];
    
    for(NSArray *ar in self.data){
        NSLog(@"Data : %@",ar);
        TKCalendarDayEventView *event = [calendarDayTimeline dequeueReusableEventView];
        if(event == nil) event = [TKCalendarDayEventView eventView];
        
        event.identifier = nil;
        event.titleLabel.text = ar[1];
        event.locationLabel.text = ar[0];
        info.hour = [ar[2] intValue];
        info.minute = [ar[3] intValue];
        info.day = [ar[8] intValue];
        //info.year = 2014;
        //info.month = [ar[7] intValue];
        event.startDate = [NSDate dateWithDateComponents:info];
        
        info.hour = [ar[4] intValue];
        info.minute = [ar[5] intValue];
        event.endDate = [NSDate dateWithDateComponents:info];
        /*
        event.identifier = nil;
        event.titleLabel.text = ar[0];
        event.locationLabel.text = ar[1];
        
        info.hour = 9;
        info.minute = 30;
        info.day = 2;
        info.year = 2014;
        info.month = 12;
        event.startDate = [NSDate dateWithDateComponents:info];
        
        info.hour = 10;
        info.minute = 30;
        event.endDate = [NSDate dateWithDateComponents:info];
        */
        [ret addObject:event];
        
    }
    return ret;
    
    
}
- (void) calendarDayTimelineView:(TKCalendarDayView*)calendarDayTimeline eventViewWasSelected:(TKCalendarDayEventView *)eventView{
    TKLog(@"%@",eventView.titleLabel.text);
}


@end