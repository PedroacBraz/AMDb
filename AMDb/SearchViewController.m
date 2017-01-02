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

    return [self.searchedMovies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    MovieSearchCell *cell = (MovieSearchCell *) [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    // Configure what the cell must display
    
    Movie *movieForCell = (self.movies)[indexPath.row];
    
    //cell.posterImageView.image = movieForCell.moviePoster;
    cell.titleLabel.text = movieForCell.title;
    cell.yearLabel.text = movieForCell.year;
    
    NSLog(@"Calling cellForRow!");
    return cell;
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
    
    NSString *myURLString = [self createURLforSearch:(searchBar.text)];
    NSURL *URL = [NSURL URLWithString:myURLString];
    Movie *movie = [[Movie alloc] init];
    
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
        
                //movie = [[Movie alloc] init];
                movie.moviePoster = [auxMovie objectForKey:@"Poster"];
                movie.title = [auxMovie objectForKey:@"Title"];
                movie.year = [auxMovie objectForKey:@"Year"];
                
                
                [_movies addObject:movie];
                
            }else{
                break;
            }
        
        }
        self.movies = _movies;
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
