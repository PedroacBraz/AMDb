//
//  SearchViewController.m
//  AMDb
//
//  Created by Mac Mini Beta on 29/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "SearchViewController.h"


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
    self.actualPage = 1;
    
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

        return self.movies.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    MovieSearchCell *cell = (MovieSearchCell *) [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    // Configure what the cell must display
    
    Movie *movieForCell = (self.movies)[indexPath.row];
    cell.titleLabel.text = movieForCell.title;
    cell.yearLabel.text = movieForCell.year;
    [cell.posterImageView setImageWithURL:[NSURL URLWithString:movieForCell.moviePosterURL]];
    cell.movieCellButton.tag = indexPath.row;
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
    URLForSearch = [URLForSearch stringByAppendingString:@"&page="];
    URLForSearch = [URLForSearch stringByAppendingString:[NSString stringWithFormat:@"%d",self.actualPage]];
    URLForSearch = [URLForSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"%@", URLForSearch);
    return URLForSearch;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do something...
        
        
        // When searching with pages, for each result in the page, the API will provide ONLY information about the movie's Title, Year, Type, imdbID and poster's URL
        NSString *myURLString = [self createURLforSearch:(searchBar.text)];
        _searchBarText = searchBar.text;
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
            
            if([[responseObject objectForKey:@"Response"] isEqualToString:@"False"]){
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No movies were found."
                                                                               message:@"You can try a new search."
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
    
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMovieDetail"]) {
        UIButton *senderButton = (UIButton *)sender;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
        // Index path is nil if invalid
        FullMovieViewController *destViewController = segue.destinationViewController;
        // The destViewController is the FullMovieViewController
        destViewController.movie = [_movies objectAtIndex:indexPath.row];
        
    }
}



@end
