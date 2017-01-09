//
//  FullMovieViewController.m
//  AMDb
//
//  Created by Mac Mini Beta on 03/01/17.
//  Copyright © 2017 Mac Mini Beta. All rights reserved.
//

#import "FullMovieViewController.h"


@interface FullMovieViewController ()

@end

@implementation FullMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // When searching with pages, for each result in the page, the API will provide ONLY information about the movie's Title, Year, Type, imdbID and poster's URL
    NSString *myURLString = [self createURLforSearch:(self.movie.title)];
    NSURL *URL = [NSURL URLWithString:myURLString];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // responseObject is _NSDictionary
        // create a Init
        _movieTitleLabel.text = [responseObject objectForKey:@"Title"];
        _movieYearLabel.text = [responseObject objectForKey:@"Year"];
        _movieRatingLabel.text = [_movieRatingLabel.text stringByAppendingString:[responseObject objectForKey:@"imdbRating"]];
        _movieSynopsisTextView.text = [responseObject objectForKey:@"Plot"];
        _movieGenreLabel.text = [_movieGenreLabel.text stringByAppendingString:[responseObject objectForKey:@"Genre"]];
        _movieActorsLabel.text = [_movieActorsLabel.text stringByAppendingString:[responseObject objectForKey:@"Actors"]];
        _movieDirectorLabel.text = [_movieDirectorLabel.text stringByAppendingString:[responseObject objectForKey:@"Director"]];
        _movieRatedLabel.text = [_movieRatedLabel.text stringByAppendingString:[responseObject objectForKey:@"Rated"]];
        _movieRuntimeLabel.text = [_movieRuntimeLabel.text stringByAppendingString:[responseObject objectForKey:@"Runtime"]];
        _moviePosterURL = [responseObject objectForKey:@"Poster"];
        [_moviePosterImageView setImageWithURL:[NSURL URLWithString:_moviePosterURL]];

        self.movietoAddInFavorites = [[Movie alloc] initWithDictionary: responseObject];
        self.movietoAddInFavorites.moviePosterData = UIImageJPEGRepresentation(self.moviePosterImageView.image, 1.0);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) createURLforSearch: (NSString *) movieTitle{
    
    
    //To return one result in the search, use:
    NSString *URLForSearch = @"http://www.omdbapi.com/?t=";
    URLForSearch = [URLForSearch stringByAppendingString:movieTitle];
    URLForSearch = [URLForSearch stringByAppendingString:@"&y=&plot=short&r=json"];
    URLForSearch= [URLForSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    //NSLog(@"%@", URLForSearch);
    return URLForSearch;
    
}



- (IBAction)favoriteMovieButtonTouched:(id)sender {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:_movietoAddInFavorites];
    [realm commitWriteTransaction];
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}
@end
