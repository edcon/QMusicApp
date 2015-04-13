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


Venue *venue;

@interface venueViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation venueViewController

{

    NSArray *venu;
}



//@synthesize tableView;

- (void)viewDidLoad {
NSLog(@"\nBeginning of viewDidLoad: %@\n", venu[0]);

    [super viewDidLoad];
    
    [self configureRestKit];
   // [NSThread sleepForTimeInterval:2.0f];
    [self loadVenues];
    
    // Do any additional setup after loading the view.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
NSLog(@"\nBeginning of numberOfRowsInSection: %@\n", venu[0]);
    return 1;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureRestKit
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
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:venueMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"nearby/40.025218/-75.323726"
                                                keyPath:@"obj"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)loadVenues
{
    NSLog(@"\nBeginning of LOADVENUES%@\n", venu[0]);

    /*NSString *lat = @"40.025218";
    NSString *lon = @"-75.323726";
    
    NSDictionary *queryParams = @{@"Latitude" : lat,
     @"Longitude" : lon,
     };*/
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"nearby/40.025218/-75.323726"
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
