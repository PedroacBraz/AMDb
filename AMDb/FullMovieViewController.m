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

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            // responseObject is _NSDictionary
            [self initFullMovieScreenWithDictionary:responseObject];
            self.movieInfos = responseObject;
            
            if ([self checkIfIsFavorited:[responseObject objectForKey:@"imdbID"]]){
                self.favoriteButton.enabled = NO;
                self.removeButton.enabled = YES;
            }else{
                self.favoriteButton.enabled = YES;
                self.removeButton.enabled = NO;
            }
            
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
}


- (void)initFullMovieScreenWithDictionary: (NSDictionary *) responseObject{

    _movieTitleLabel.text = [responseObject objectForKey:@"Title"];
    _movieYearLabel.text = [_movieYearLabel.text stringByAppendingString:[responseObject objectForKey:@"Released"]];
    _movieRatingLabel.text = [_movieRatingLabel.text stringByAppendingString:[responseObject objectForKey:@"imdbRating"]];
    _movieSynopsisTextView.text = [responseObject objectForKey:@"Plot"];
    _movieGenreLabel.text = [_movieGenreLabel.text stringByAppendingString:[responseObject objectForKey:@"Genre"]];
    _movieActorsLabel.text = [_movieActorsLabel.text stringByAppendingString:[responseObject objectForKey:@"Actors"]];
    _movieDirectorLabel.text = [_movieDirectorLabel.text stringByAppendingString:[responseObject objectForKey:@"Director"]];
    _movieRatedLabel.text = [_movieRatedLabel.text stringByAppendingString:[responseObject objectForKey:@"Rated"]];
    _movieRuntimeLabel.text = [_movieRuntimeLabel.text stringByAppendingString:[responseObject objectForKey:@"Runtime"]];
    _moviePosterURL = [responseObject objectForKey:@"Poster"];
    [_moviePosterImageView setImageWithURL:[NSURL URLWithString:_moviePosterURL]];

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
    URLForSearch = [URLForSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return URLForSearch;
    
}

- (IBAction)removeMovieButtonTouched:(id)sender {
        
    RLMResults<Movie *> *movieToDelete = [Movie objectsWhere:@"imdbID = %@", [_movieInfos objectForKey:@"imdbID"]];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:movieToDelete];
    [realm commitWriteTransaction];
    _removeButton.enabled = NO;
    _favoriteButton.enabled = YES;

    
}

- (IBAction)favoriteMovieButtonTouched:(id)sender {
    

    self.movietoAddInFavorites = [[Movie alloc] initWithDictionary: _movieInfos];
    self.movietoAddInFavorites.moviePosterData = UIImageJPEGRepresentation(self.moviePosterImageView.image, 1.0);
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:_movietoAddInFavorites];
    [realm commitWriteTransaction];
    
    _favoriteButton.enabled = NO;
    _removeButton.enabled = YES;
    
    //NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
}

- (IBAction)showFullScreenPoster:(id)sender {
    
    [EXPhotoViewer showImageFrom:self.moviePosterImageView];
}

- (BOOL)checkIfIsFavorited:(NSString *) imdbID{
    
    RLMResults <Movie *> *movieWithID = [Movie objectsWhere:@"imdbID = %@", imdbID];
    NSLog(@"%lu", (unsigned long)movieWithID.count);
    
    if(movieWithID.count > 0){
        return YES;
    }else{
        return NO;
    }

}

@end
