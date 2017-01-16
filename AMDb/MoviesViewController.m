//
//  MoviesViewController.m
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "MoviesViewController.h"


@interface MoviesViewController ()

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    movieResults = [Movie allObjects];
    movieResults = [movieResults sortedResultsUsingProperty:@"title" ascending:YES];
    
    if(movieResults.count == 0){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No favorite movies yet!"
                                                                       message:@"You can use the search button above to find your favorite movies."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
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

    return [movieResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    // Configure what the cell must display
    
    Movie *movie = [movieResults objectAtIndex:indexPath.row];

    cell.posterImageView.image = [UIImage imageWithData:movie.moviePosterData];
    cell.titleLabel.text = movie.title;
    cell.yearLabel.text = movie.year;
    cell.ratingLabel.text = @"Rating: ";
    cell.ratingLabel.text = [cell.ratingLabel.text stringByAppendingString:movie.rating];
    cell.shortSynopsisLabel.text = movie.shortSynopsis;
    cell.movieCellButton.tag = indexPath.row;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = cell.posterImageView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0.95f, 1.00f);
    gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
    cell.posterImageView.layer.mask = gradientLayer;
    
    
    if ([_movies count] == 0){
        cell.noMoviesLabel.enabled = YES;
    }
    
    return cell;
}


-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMovieDetail"]) {
        
        UIButton *senderButton = (UIButton *)sender;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
        // Index path is nil if invalid
        FullMovieViewController *destViewController = segue.destinationViewController;
        // The destViewController is the FullMovieViewControlle;
        destViewController.movie = [movieResults objectAtIndex:indexPath.row];
        
    }
}



@end
