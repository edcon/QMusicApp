//
//  TheQueCell.m
//  QMusicApp
//
//  Created by Patrick DePippo on 2/8/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import "TheQueCell.h"

@implementation TheQueCell

@synthesize nameLabel;
@synthesize artistLabel;
@synthesize voteNumber;
@synthesize songArtwork;
@synthesize voteButton;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
