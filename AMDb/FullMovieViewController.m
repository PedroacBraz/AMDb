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
    /*
    // When searching with pages, for each result in the page, the API will provide ONLY information about the movie's Title, Year, Type, imdbID and poster's URL
    NSString *myURLString = [self createURLforSearch:(self.movie.title)];

    
        NSURL *URL = [NSURL URLWithString:myURLString];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            // responseObject is _NSDictionary
            [self initFullMovieScreenWithDictionary:responseObject];
            self.movieInfos = responseObject;
            
            if ([self checkIfIsFavorited:[responseObject objectForKey:@"imdbID"]]){
                [self.favoriteOrDeleteMovieButton setTitle:@"Remove from Favorites" forState:UIControlStateNormal];
            }else{
                [self.favoriteOrDeleteMovieButton setTitle:@"Add to Favorites" forState:UIControlStateNormal];
            }
            
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];

     */
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    NSString *myURLString = [self createURLforSearch:(self.movie.title)];
    
    NSURL *URLforSearch = [NSURL URLWithString:myURLString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URLforSearch];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"An error has occurred!"
                                          message:@"Try again."
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
            
            [alert addAction:Ok];
            [self presentViewController:alert animated:YES completion:nil];
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
            [dataTask resume];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
        } else {
            NSLog(@"JSON: %@", responseObject);
            // responseObject is _NSDictionary
            [self initFullMovieScreenWithDictionary:responseObject];
            self.movieInfos = responseObject;
            //Gradient image effect
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = self.moviePosterImageView.bounds;
            gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
            gradientLayer.startPoint = CGPointMake(1.0f, 0.95f);
            gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
            self.moviePosterImageView.layer.mask = gradientLayer;
            
            
            if ([self checkIfIsFavorited:[responseObject objectForKey:@"imdbID"]]){
                [self.favoriteOrDeleteMovieButton setTitle:@"Remove from Favorites" forState:UIControlStateNormal];
            }else{
                [self.favoriteOrDeleteMovieButton setTitle:@"Add to Favorites" forState:UIControlStateNormal];
            }

            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
        }
    }];
    //Show Loading:
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.label.text = @"Loading";
    [_hud hideAnimated:YES];
    [_hud showAnimated:YES];
    //call afnetwork in dataTask
    [dataTask resume];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
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


- (IBAction)favoriteOrRemoveButtonTouched:(id)sender {
    
    UIButton *movieButton = (UIButton*)sender;
    if([movieButton.titleLabel.text isEqualToString:@"Remove from Favorites"]){
        RLMResults<Movie *> *movieToDelete = [Movie objectsWhere:@"imdbID = %@", [_movieInfos objectForKey:@"imdbID"]];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObjects:movieToDelete];
        [realm commitWriteTransaction];
        [self.favoriteOrDeleteMovieButton setTitle:@"Add to Favorites" forState:UIControlStateNormal];
        
    }else if([movieButton.titleLabel.text isEqualToString:@"Add to Favorites"]){
        
        self.movietoAddInFavorites = [[Movie alloc] initWithDictionary: _movieInfos];
        self.movietoAddInFavorites.moviePosterData = UIImageJPEGRepresentation(self.moviePosterImageView.image, 1.0);
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:_movietoAddInFavorites];
        [realm commitWriteTransaction];
        [self.favoriteOrDeleteMovieButton setTitle:@"Remove from Favorites" forState:UIControlStateNormal];
    }
    
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
