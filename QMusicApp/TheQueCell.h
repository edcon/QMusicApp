//
//  TheQueCell.h
//  QMusicApp
//
//  Created by Patrick DePippo on 2/8/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheQueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* artistLabel;
@property (nonatomic, weak) IBOutlet UILabel* voteNumber;
@property (nonatomic, weak) IBOutlet UIImageView* songArtwork;
@property (nonatomic, weak) IBOutlet UIButton* voteButton;

@end
