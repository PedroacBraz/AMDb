//
//  MoviesViewController.m
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "MoviesViewController.h"
#import "Movie.h"
#import "MovieCell.h"

@interface MoviesViewController ()

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    MovieCell *cell = (MovieCell *) [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    // Configure what the cell must display
    
    Movie *movie = (self.movies)[indexPath.row];
    
    cell.posterImageView.image = movie.moviePoster;
    cell.titleLabel.text = movie.title;
    cell.yearLabel.text = movie.year;
    cell.ratingLabel.text = @"Rating: ";
    cell.ratingLabel.text = [cell.ratingLabel.text stringByAppendingString:movie.rating];
    cell.shortSynLabel.text = movie.shortSynopsis;

    
    return cell;
}


@end
