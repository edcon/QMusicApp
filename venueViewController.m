//
//  venueViewController.m
//  QMusicApp
//
//  Created by wildcat on 4/6/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import "venueViewController.h"
#import "Venue.h"
#import <RestKit/RestKit.h>
#import "TheQueCell.h"
#import "ViewController.h"


Venue *venue;

@interface venueViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation venueViewController

{
    Venue *venueSel;
    NSArray *venu;


}


@synthesize lon;
@synthesize lat;
//@synthesize tableView;

- (void)viewDidLoad {
NSLog(@"\n\n\nBeginning of viewDidLoad lat: %@, lon: %@\n\n\n", lat,lon);

    

    
    [self configureRestKit:lat longitdue:lon];
    // [NSThread sleepForTimeInterval:2.0f];
    [self loadVenues:lat longitdue:lon];
    //     [NSThread sleepForTimeInterval:5.0f];
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//*****************************************************************************************************\\
//****************************************  TABLE VIEW  ***********************************************\\
//*****************************************************************************************************\\


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
NSLog(@"\nBeginning of numberOfRowsInSection: %@\n", venu[0]);
    return venu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{NSLog(@"\nBeginning of cellForRowAtIndexPath: %@\n", venu[0]);
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [venu objectAtIndex:indexPath.row];
    //[self.venueTableView reloadData];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    venueSel = [_venues objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier: @"venueSelected" sender: self];
    
     //   UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Venue Selected" message:@"You've selected a venue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //    [messageAlert show];
}


//*****************************************************************************************************\\
//*******************************************  RESTKIT  ***********************************************\\
//*****************************************************************************************************\\
 
 
- (void)configureRestKit:(NSString *)latitudeC longitdue:(NSString *)longitudeC
{  NSLog(@"\nBeginning of ConfigureRestkit: %@\n", venu[0]);

    // [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/json"];
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://q-music.herokuapp.com/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    //NSLog(@"/n Latitude: %.8f, Longitude: %.8f",40.02302400,-75.31517700);
    //NSLog(@"/n Lat: %@, Lon: %@",lat,lon);

    NSString *combined = [NSString stringWithFormat:@"nearby/%@/%@", latitudeC, longitudeC];

    //NSString *combined = [NSString stringWithFormat:@"nearby/-40.02302400/75.31517700"];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:venueMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:combined                                                keyPath:@"obj"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)loadVenues:(NSString *)latitudeV longitdue:(NSString *)longitudeV
{
   // NSLog(@"\nBeginning of LOADVENUES%@\n", venu[0]);


  NSString *combined = [NSString stringWithFormat:@"nearby/%@/%@", latitudeV, longitudeV];
//    NSString *combined = [NSString stringWithFormat:@"nearby/-40.02302400/75.31517700"];
    NSLog(@"Combined lat and long in LOADVENUES \n %@  \n",combined);
    
    [[RKObjectManager sharedManager] getObjectsAtPath:combined
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _venues = mappingResult.array;
                                                  venu = [_venues valueForKey:@"name"];
                                                  NSLog(@"\nNAME OF VENUE8888: %@\n", venu[0]);
                                                //  [self.venueTableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
    //[self.venueTableView reloadData];
    [NSThread sleepForTimeInterval:0.7f];
    NSLog(@"\n\nEND of LOADVENUES%@\n\n", venu[0]);

}





/*
#pragma mark - Navigation
*/
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 if([segue.identifier isEqualToString:@"venueSelected"]){
     NSString *venueSelected;
 
     ViewController *vController = (ViewController *)segue.destinationViewController;
     venueSelected = [venueSel valueForKey:@"name"];
     vController.venueName =venueSelected;
    
 }
 

 }

@end
