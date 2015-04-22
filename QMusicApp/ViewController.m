//
//  ViewController.m
//  QMusicApp
//
//  Created by Patrick DePippo on 2/8/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import "ViewController.h"
#import "TheQueCell.h"
#import <RestKit/RestKit.h>
#import "Venue.h"
#import "venueViewController.h"
#import "Song.h"

NSArray *venu;

@interface ViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation ViewController
bool newCell = FALSE;
NSArray *songNames;
NSArray *artistNames;
NSArray *numberVotes;
NSArray *songImages;
NSString *voteUp;
NSNumber *upVote;

CLLocation *crnLoc;


@synthesize tableView;
@synthesize venueButton;
@synthesize currentSongLabel;
@synthesize currentArtistLabel;
@synthesize suggesterLabel;
@synthesize currentArtwork;
@synthesize voteButton;
@synthesize songProgress;

@synthesize locationManager;
@synthesize lat;
@synthesize lon;

@synthesize display;
@synthesize detail;
@synthesize songImage;




- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    //GET LOCATION
    
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    
    locationManager.delegate = self; // set the delegate of locationManager to self.
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    // Check for iOS 8 to prevent errors in iOs 7
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
    [locationManager startUpdatingLocation];  //requesting location updates
    

    

    [self.tableView reloadData];
  
    
    
    //Handle venue information and current playing song info
    [venueButton setTitle:@"Kelly's Taproom" forState:UIControlStateNormal];
    currentSongLabel.text = @"Hell of a Night";
    currentArtistLabel.text = @"Schoolboy Q";
    suggesterLabel.text = @"JohnDoe6";
    currentArtwork.image = [UIImage imageNamed:@"hellofanight@2x.png"];
    currentArtwork.image = [UIImage imageNamed:@"hellofanight@2x.png"];
    
    currentArtwork.layer.cornerRadius = 5.0;
    currentArtwork.layer.masksToBounds = YES;
    
    currentArtwork.layer.borderColor = [UIColor whiteColor].CGColor;
    currentArtwork.layer.borderWidth = 1.0;
    
    venueButton.layer.cornerRadius = 10; // this value vary as per your desire
    venueButton.clipsToBounds = YES;
    
    //Dummy data for song queue
    
    songNames = [NSArray arrayWithObjects:@"Hey Ya",@"Money Trees",@"Come On To Me",@"Flourescent Adolescent", @"Float On", @"Times Like These", @"Whole Lotta Love", @"Bad Romance", @"TNT", @"Here I Am", nil];
    artistNames = [NSArray arrayWithObjects:@"OutKast",@"Kendrick Lamar",@"Major Lazer",@"Arctic Monkeys", @"Modest Mouse", @"Foo Fighters", @"Led Zeppelin", @"Lady Gaga", @"ACDC", @"Rick Ross", nil];
    numberVotes = [NSArray arrayWithObjects: @"17",@"1",@"12",@"9", @"7", @"7", @"4", @"4", @"2", @"15",  nil];
    songImages = [NSArray arrayWithObjects:@"OutkastHeyYa@2x.png",@"KendrickGKMC@2x.png",@"majorlazer@2x.png",@"Fluorescent_Adolescent@2x.png", @"goodnews@2x.png", @"timeslikethese@2x.png", @"Wllsingle@2x.png", @"LadyGaGaBadRomance@2x.png", @"tnt@2x.png", @"ricky@2x.png", nil];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateView];
}

- (void)updateView
{
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *path3 = [NSIndexPath indexPathForRow:2 inSection:0];

    NSArray *indexArray = [NSArray arrayWithObjects:path1,path2, path3, nil];
    [tableView beginUpdates];
    
    [tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];
    
    [tableView endUpdates];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString *simpleTableIdentifier = @"TheQueCell";

    TheQueCell *cell = (TheQueCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //TheQueCell *cell = (TheQueCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheQueCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //Venue *venueName = venu[indexPath.row];
    //NSLog(@"\nNAME OF VENUE2: %@\n", venu[0]);
if(newCell == FALSE){
    cell.nameLabel.text = [songNames objectAtIndex:indexPath.row];
    cell.artistLabel.text = [artistNames objectAtIndex:indexPath.row];
    cell.voteNumber.text = [numberVotes objectAtIndex:indexPath.row];
    cell.songArtwork.image = [UIImage imageNamed:[songImages objectAtIndex:indexPath.row]];
    return cell;
    }else{
        NSLog(@"name: %@", display);
        NSLog(@"artist: %@", detail);

        cell.nameLabel.text = display;
        cell.artistLabel.text = detail;
        cell.voteNumber.text = @"1";
        cell.songArtwork.image = [UIImage imageNamed:songImage];
        cell.voteIcon.image = [UIImage imageNamed:@"arrowgreen@2x.png"];
        cell.isUpvoted = TRUE;
        newCell = FALSE;
return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    static NSString *simpleTableIdentifier = @"TheQueCell";
    TheQueCell *cell = (TheQueCell *)[tableView cellForRowAtIndexPath:indexPath];

    voteUp = cell.voteNumber.text;
    
    if(cell.isUpvoted == FALSE){
        upVote = @([voteUp intValue] + 1);
        cell.voteIcon.image = [UIImage imageNamed:@"arrowgreen@2x.png"];

    } else {
        upVote = @([voteUp intValue] - 1);
        cell.voteIcon.image = [UIImage imageNamed:@"arrow@2x.png"];

    }
    
    
   /*NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numberVotes" ascending:TRUE];
    numberVotes = [numberVotes sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [tableView reloadData];*/
    
    
    cell.voteNumber.text = [NSString stringWithFormat:@"%@",upVote];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
//    [messageAlert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

//*****************************************************************************************************\\
//*******************************************  LOCATION  **********************************************\\
//*****************************************************************************************************\\

//When location is updated log location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    NSLog(@"%@", [locations lastObject]); //Log Location
    crnLoc = [locations lastObject];
  
    
    [locationManager stopUpdatingLocation];  //stop requesting location updates
    
    
 
    
}

// Deal with errors retrieving location
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
    
}


//*****************************************************************************************************\\
//*****************************************************************************************************\\
//*****************************************************************************************************\\


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showVenuesSegue"]){
        NSString *latitude, *longitude;
        latitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
        longitude = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
        NSLog(@"\n\n LATITUDE: %@, LONGITUDE: %@\n\n",latitude,longitude);

        venueViewController *controller = (venueViewController *)segue.destinationViewController;
        controller.lat =latitude ;
        controller.lon = longitude;
    }
}

@end
