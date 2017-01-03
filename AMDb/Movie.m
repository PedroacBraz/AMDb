//
//  Movie.m
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (Movie *) initWithDictionary:(NSDictionary *)movieDictionary{

    Movie * movie = [[Movie alloc] init];
    
    if (!movie){
        return nil;
    }
    
    movie.moviePosterURL = [movieDictionary objectForKey:@"Poster"];
    movie.title = [movieDictionary objectForKey:@"Title"];
    movie.year = [movieDictionary objectForKey:@"Year"];
    
    return movie;
    
}

- (void) getPosterWithURL: (NSURL *) moviePosterURL{

  


}


@end
