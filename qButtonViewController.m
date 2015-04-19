//
//  qButtonViewController.m
//  QMusicApp
//
//  Created by wildcat on 4/6/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import "qButtonViewController.h"
#import "TheQueCell.h"
@interface qButtonViewController ()

@end

@implementation qButtonViewController
NSArray *songNames;
NSArray *artistNames;
NSArray *numberVotes;
NSArray *songImages;
NSString *voteUp;
NSNumber *upVote;

- (void)viewDidLoad {
    [super viewDidLoad];
 
        
        songNames = [NSArray arrayWithObjects:@"Hey Ya",@"Money Trees",@"Come On To Me",@"Flourescent Adolescent", @"Float On", @"Times Like These", @"Whole Lotta Love", @"Bad Romance", @"TNT", @"Here I Am", nil];
    artistNames = [NSArray arrayWithObjects:@"OutKast",@"Kendrick Lamar",@"Major Lazer",@"Arctic Monkeys", @"Modest Mouse", @"Foo Fighters", @"Led Zeppelin", @"Lady Gaga", @"ACDC", @"Rick Ross", nil];
    numberVotes = [NSArray arrayWithObjects: @"17",@"1",@"12",@"9", @"7", @"7", @"4", @"4", @"2", @"15",  nil];
    songImages = [NSArray arrayWithObjects:@"OutkastHeyYa@2x.png",@"KendrickGKMC@2x.png",@"majorlazer@2x.png",@"Fluorescent_Adolescent@2x.png", @"goodnews@2x.png", @"timeslikethese@2x.png", @"Wllsingle@2x.png", @"LadyGaGaBadRomance@2x.png", @"tnt@2x.png", @"ricky@2x.png", nil];
    
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
    
    cell.nameLabel.text = [songNames objectAtIndex:indexPath.row];
    cell.artistLabel.text = [artistNames objectAtIndex:indexPath.row];
    cell.voteNumber.text = [numberVotes objectAtIndex:indexPath.row];
    cell.songArtwork.image = [UIImage imageNamed:[songImages objectAtIndex:indexPath.row]];
      cell.voteIcon.hidden = YES;
    cell.voteNumber.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *simpleTableIdentifier = @"TheQueCell";
    TheQueCell *cell = (TheQueCell *)[tableView cellForRowAtIndexPath:indexPath];
   
    //voteUp = cell.voteNumber.text;
    /*
    if(cell.isUpvoted == FALSE){
        upVote = @([voteUp intValue] + 1);
        cell.voteIcon.hidden = YES;
       // cell.voteIcon.image = [UIImage imageNamed:@"arrowgreen@2x.png"];
        
    } else {
        upVote = @([voteUp intValue] - 1);
        cell.voteIcon.hidden = YES;// [UIImage imageNamed:@"arrow@2x.png"];
        
    }*/
    
    
    /*NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numberVotes" ascending:TRUE];
     numberVotes = [numberVotes sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
     [tableView reloadData];*/
    
    
    //cell.voteNumber.text = [NSString stringWithFormat:@"%@",upVote];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    //    [messageAlert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
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
