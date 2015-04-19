//
//  ViewController.h
//  QMusicApp
//
//  Created by Patrick DePippo on 2/8/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton* venueButton;
@property (nonatomic, weak) IBOutlet UILabel* currentSongLabel;
@property (nonatomic, weak) IBOutlet UILabel* currentArtistLabel;
@property (nonatomic, weak) IBOutlet UILabel* suggesterLabel;
@property (nonatomic, weak) IBOutlet UIImageView* currentArtwork;
@property (nonatomic, weak) IBOutlet UIButton* voteButton;
@property (nonatomic, strong) IBOutlet UISlider* songProgress;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSString *lat;
@property (nonatomic) NSString *lon;

@end

