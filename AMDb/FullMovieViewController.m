//
//  FullMovieViewController.m
//  AMDb
//
//  Created by Mac Mini Beta on 03/01/17.
//  Copyright © 2017 Mac Mini Beta. All rights reserved.
//

#import "FullMovieViewController.h"
#import "UIImageView+AFNetworking.h"

@interface FullMovieViewController ()

@end

@implementation FullMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Movie %@", self.movie.title);
    
    // When searching with pages, for each result in the page, the API will provide ONLY information about the movie's Title, Year, Type, imdbID and poster's URL
    NSString *myURLString = [self createURLforSearch:(self.movie.title)];
    NSURL *URL = [NSURL URLWithString:myURLString];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // responseObject is _NSDictionary
        
        //movie.moviePosterURL = [movieDictionary objectForKey:@"Poster"];
        _movieTitleLabel.text = [responseObject objectForKey:@"Title"];
        _movieYearLabel.text = [responseObject objectForKey:@"Year"];
        _movieRatingLabel.text = [_movieRatingLabel.text stringByAppendingString:[responseObject objectForKey:@"imdbRating"]];
        
        _movieSynopsisTextView.text = [responseObject objectForKey:@"Plot"];
        _moviePosterURL = [responseObject objectForKey:@"Poster"];
        
        [_moviePosterImageView setImageWithURL:[NSURL URLWithString:_moviePosterURL]];
        
        
        /*
         
        MTLSearchMovies *searchMovies = [MTLJSONAdapter modelOfClass:[MTLSearchMovies class] fromJSONDictionary:responseObject error:NULL];
        
        self.searchedMovies = [[NSMutableArray alloc] initWithObjects:searchMovies, nil];
        // Here, searched movies has the response, searchResults and searchResultsQty
        // seachResults is a NSArray with the movies data in each position, now, to use each position to create a movie and add it on movies array
        for (NSDictionary *auxMovie in searchMovies.searchResults){
            
            if (auxMovie != nil){
                
         [self.movies addObject:[[Movie alloc] initWithDictionary: auxMovie]];
                
            }
        }
        
        [self.tableView reloadData];
        */
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
    
    NSLog(@"%@", URLForSearch);
    return URLForSearch;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
