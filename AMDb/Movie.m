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
    
    movie.moviePosterURL    = [movieDictionary objectForKey:@"Poster"];
    movie.title             = [movieDictionary objectForKey:@"Title"];
    movie.year              = [movieDictionary objectForKey:@"Year"];
    movie.actors            = [movieDictionary objectForKey:@"Actors"];
    movie.director          = [movieDictionary objectForKey:@"Director"];
    movie.genre             = [movieDictionary objectForKey:@"Genre"];
    movie.rated             = [movieDictionary objectForKey:@"Rated"];
    movie.runtime           = [movieDictionary objectForKey:@"Runtime"];
    movie.rating            = [movieDictionary objectForKey:@"Rating"];
    movie.shortSynopsis     = [movieDictionary objectForKey:@"Runtime"];
    
    return movie;
    
}

@end
