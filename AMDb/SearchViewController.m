//
//  SearchViewController.m
//  AMDb
//
//  Created by Mac Mini Beta on 29/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "SearchViewController.h"
#import "MTLSearchMovie.h"
#import "MovieSearchCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "FullMovieViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    NSMutableArray *_movies;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    _movies = [NSMutableArray arrayWithCapacity:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    MovieSearchCell *cell = (MovieSearchCell *) [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    // Configure what the cell must display
    
    Movie *movieForCell = (self.movies)[indexPath.row];
    
    //cell.posterImageView.image = movieForCell.moviePoster;
    cell.titleLabel.text = movieForCell.title;
    cell.yearLabel.text = movieForCell.year;
    [cell.posterImageView setImageWithURL:[NSURL URLWithString:movieForCell.moviePosterURL]];
    
    NSLog(@"Calling cellForRow!");
    return cell;
}

- (IBAction)touchedMoviePosterButton:(id)sender {
}

- (NSString *) createURLforSearch: (NSString *) movieTitle{
    
    //To return one result in the search, use:
    //NSString *URLForSearch = @"http://www.omdbapi.com/?t=";
    
    //To return one or more result in the search,use:
    NSString *URLForSearch = @"http://www.omdbapi.com/?s=";
    
    URLForSearch = [URLForSearch stringByAppendingString:movieTitle];
    URLForSearch = [URLForSearch stringByAppendingString:@"&y=&plot=short&r=json"];
    
    URLForSearch= [URLForSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"%@", URLForSearch);
    return URLForSearch;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    // When searching with pages, for each result in the page, the API will provide ONLY information about the movie's Title, Year, Type, imdbID and poster's URL
    NSString *myURLString = [self createURLforSearch:(searchBar.text)];
    NSURL *URL = [NSURL URLWithString:myURLString];
       [_movies removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // responseObject is _NSDictionary
        
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
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMovieDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        // Index path is nil if invalid
        FullMovieViewController *destViewController = segue.destinationViewController;
        // The destViewController is the FullMovieViewController
        destViewController.movie = [_movies objectAtIndex:indexPath.row];
        
    }
}



@end
