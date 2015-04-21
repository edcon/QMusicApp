//
//  qButtonViewController.m
//  QMusicApp
//
//  Created by wildcat on 4/6/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import "qButtonViewController.h"
#import "TheQueCell.h"
#import "Song.h"
#import <RestKit/RestKit.h>
#import "ViewController.h"

@interface qButtonViewController ()

@end

@implementation qButtonViewController


{
    
    Song *songSel;
    
    
    NSArray *songs;
    NSArray *searchResults;
    
    NSArray *songNames2;
NSArray *songNames;
NSArray *artistNames;
NSArray *numberVotes;
NSArray *songImages;
NSString *voteUp;
NSNumber *upVote;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Song *song1 = [Song new];
    song1.display = @"Pursuit of Happiness";
    song1.detail = @"Kid Cudi";
    song1.image = @"poh.jpg";
    
    Song *song2 = [Song new];
    song2.display = @"17 Years";
    song2.detail = @"Ratatat";
    song2.image = @"ratatat.jpg";
    
    Song *song3 = [Song new];
    song3.display = @"Say My Name";
    song3.detail = @"ODESZA";
    song3.image = @"smn.jpg";
 
    
    Song *song4 = [Song new];
    song4.display = @"Pay No Mind";
    song4.detail = @"Madeon";
    song4.image = @"adventure.png";
    
    Song *song5 = [Song new];
    song5.display = @"Heads Will Roll (A-track Remix)";
    song5.detail = @"Yeah Yeah Yeahs";
    song5.image = @"hwr.jpg";
    
    Song *song6 = [Song new];
    song6.display = @"Firestone";
    song6.detail = @"Kygo";
    song6.image = @"kygo.jpg";
    songs = [NSArray arrayWithObjects:song1,song2,song3, song4, song5, song6, nil];
    

        songNames = [NSArray arrayWithObjects:@"Hey Ya",@"Money Trees",@"Come On To Me",@"Flourescent Adolescent", @"Float On", @"Times Like These", @"Whole Lotta Love", @"Bad Romance", @"TNT", @"Here I Am", nil];
    artistNames = [NSArray arrayWithObjects:@"OutKast",@"Kendrick Lamar",@"Major Lazer",@"Arctic Monkeys", @"Modest Mouse", @"Foo Fighters", @"Led Zeppelin", @"Lady Gaga", @"ACDC", @"Rick Ross", nil];
    numberVotes = [NSArray arrayWithObjects: @"17",@"1",@"12",@"9", @"7", @"7", @"4", @"4", @"2", @"15",  nil];
    songImages = [NSArray arrayWithObjects:@"OutkastHeyYa@2x.png",@"KendrickGKMC@2x.png",@"majorlazer@2x.png",@"Fluorescent_Adolescent@2x.png", @"goodnews@2x.png", @"timeslikethese@2x.png", @"Wllsingle@2x.png", @"LadyGaGaBadRomance@2x.png", @"tnt@2x.png", @"ricky@2x.png", nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [songs count];
    }
    
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
    Song *song = nil;

    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        song = [searchResults objectAtIndex:indexPath.row];
    } else {
        song = [songs objectAtIndex:indexPath.row];
    }
    
    
    cell.nameLabel.text = song.display;//[songs objectAtIndex:indexPath.row];
    cell.artistLabel.text = song.detail;//[artistNames objectAtIndex:indexPath.row];
    //cell.voteNumber.text = [numberVotes objectAtIndex:indexPath.row];
    cell.songArtwork.image = [UIImage imageNamed:song.image];
    cell.voteIcon.hidden = YES;
    cell.voteNumber.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    //static NSString *simpleTableIdentifier = @"TheQueCell";
    //TheQueCell *cell = (TheQueCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
   
    
    songSel = [songs objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier: @"songSelected" sender: self];
    
    //    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //    [messageAlert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"display contains[c] %@", searchText];
    searchResults = [songs filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//*****************************************************************************************************\\
//*******************************************  RESTKIT  ***********************************************\\
//*****************************************************************************************************\\

/*
- (void)configureRestKit:(NSString *)latitudeC longitdue:(NSString *)longitudeC
{  
    
    // [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/json"];
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://q-music.herokuapp.com/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *songMapping = [RKObjectMapping mappingForClass:[Song class]];
    [songMapping addAttributeMappingsFromArray:@[@"display", @"detail"]];
    
    //NSLog(@"/n Latitude: %.8f, Longitude: %.8f",40.02302400,-75.31517700);
   // NSLog(@"/n Lat: %@, Lon: %@",lat,lon);
    
    
   // NSString *combined = [NSString stringWithFormat:@"nearby/40.02302400/75.31517700"];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:songMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/search"                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)loadVenues:(NSString *)latitudeV longitdue:(NSString *)longitudeV stringS:(NSString *)search
{
    // NSLog(@"\nBeginning of LOADVENUES%@\n", venu[0]);
    
    
    //    NSString *combined = [NSString stringWithFormat:@"nearby/%@/%@", latitudeV, longitudeV];
    
    NSDictionary *queryParams = @{@"detail" : search,
                                  };
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/search"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  songs = mappingResult.array;
                                                  songNames2 = [songs valueForKey:@"detail"];
                                                  NSLog(@"\nNAME OF SONG: %@\n", songNames2[0]);
                                                  //  [self.venueTableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
    //[self.venueTableView reloadData];
    [NSThread sleepForTimeInterval:0.7f];
   // NSLog(@"\n\nEND of LOADVENUES%@\n\n", venu[0]);
    
}


*/


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"songSelected"]){
       
        //NSLog(@"\n\n LATITUDE: %@, LONGITUDE: %@\n\n",latitude,longitude);
        
        ViewController *controller = (ViewController *)segue.destinationViewController;
        controller.display =songSel.display ;
        controller.detail = songSel.detail;
        controller.songImage =songSel.image;
        controller.newCell = TRUE;
    }
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
