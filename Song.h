//
//  Song.h
//  QMusicApp
//
//  Created by wildcat on 4/20/15.
//  Copyright (c) 2015 Patrick DePippo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, strong) NSString *trackname; // name of song
@property (nonatomic, strong) NSString *trackartist; // artist name
@property (nonatomic, strong) NSString *trackalbum;
@property (nonatomic, strong) NSString *trackid;
@property (nonatomic, strong) NSString *trackvotes;
@property (nonatomic, strong) NSString *currenttrack;


@end
