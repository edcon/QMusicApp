//
//  ViewController.m
//  QMusicApp
//
//  Created by Patrick DePippo on 2/8/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import "ViewController.h"
#import "TheQueCell.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *songNames;
NSArray *artistNames;
NSArray *numberVotes;
NSArray *songImages;


@synthesize tableView;
@synthesize venueLabel;
@synthesize currentSongLabel;
@synthesize currentArtistLabel;
@synthesize suggesterLabel;
@synthesize currentArtwork;
@synthesize voteButton;
@synthesize songProgress;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Handle venue information and current playing song info
    venueLabel.text = @"Kellys Taproom";
    currentSongLabel.text = @"Hell of a Night";
    currentArtistLabel.text = @"Schoolboy Q";
    suggesterLabel.text = @"JohnDoe6";
    currentArtwork.image = [UIImage imageNamed:@"hellofanight@2x.png"];
    currentArtwork.image = [UIImage imageNamed:@"hellofanight@2x.png"];
    
    //Dummy data for song queue
    songNames = [NSArray arrayWithObjects:@"Hey Ya",@"Money Trees",@"Come On To Me",@"Flourescent Adolescent", @"Float On", @"Times Like These", @"Whole Lotta Love", @"Bad Romance", @"TNT", @"Here I Am", nil];
    artistNames = [NSArray arrayWithObjects:@"OutKast",@"Kendrick Lamar",@"Major Lazer",@"Arctic Monkeys", @"Modest Mouse", @"Foo Fighters", @"Led Zeppelin", @"Lady Gaga", @"ACDC", @"Rick Ross", nil];
    numberVotes = [NSArray arrayWithObjects:@"17",@"15",@"12",@"9", @"7", @"7", @"5", @"4", @"2", @"1",  nil];
    songImages = [NSArray arrayWithObjects:@"OutkastHeyYa@2x.png",@"KendrickGKMC@2x.png",@"majorlazer@2x.png",@"Fluorescent_Adolescent@2x.png", @"goodnews@2x.png", @"timeslikethese@2x.png", @"", @"", @"", @"", nil];
    

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
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheQueCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.nameLabel.text = [songNames objectAtIndex:indexPath.row];
    cell.artistLabel.text = [artistNames objectAtIndex:indexPath.row];
    cell.voteNumber.text = [numberVotes objectAtIndex:indexPath.row];
    cell.songArtwork.image = [UIImage imageNamed:[songImages objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}



@end
