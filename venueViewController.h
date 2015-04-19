//
//  venueViewController.h
//  QMusicApp
//
//  Created by wildcat on 4/6/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface venueViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString *lat;
@property (nonatomic) NSString *lon;


//@property (strong, nonatomic) IBOutlet UITableView *venueTableView;
@end
