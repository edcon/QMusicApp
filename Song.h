//
//  Song.h
//  QMusicApp
//
//  Created by wildcat on 4/20/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, strong) NSString *display; // name of song
@property (nonatomic, strong) NSString *detail; // artist name
@property (nonatomic, strong) NSString *image; // image filename
@property (nonatomic, strong) NSString *numVotes;


@end
