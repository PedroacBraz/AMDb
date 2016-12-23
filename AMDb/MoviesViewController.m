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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    /*
    UIImageView *posterImageView = (UIImageView *)[cell viewWithTag:101];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    titleLabel.text = movie.title;
    UILabel *yearLabel = (UILabel *)[cell viewWithTag:103];
    yearLabel.text = movie.year;
    UILabel *ratingLabel = (UILabel *)[cell viewWithTag:104];
    ratingLabel.text = @"Rating: ";
    ratingLabel.text = [ratingLabel.text stringByAppendingString:movie.rating];
    UILabel *shortSynLabel = (UILabel *)[cell viewWithTag:105];
    shortSynLabel.numberOfLines = 0;
    shortSynLabel.text = movie.shortSynopsis;
     */


    
    return cell;
}


- (UIImage *)imageForRating:(int)rating
{
    switch (rating) {
        case 1: return [UIImage imageNamed:@"posterArrival"];
        case 2: return [UIImage imageNamed:@"2StarsSmall"];
        case 3: return [UIImage imageNamed:@"3StarsSmall"];
        case 4: return [UIImage imageNamed:@"4StarsSmall"];
        case 5: return [UIImage imageNamed:@"5StarsSmall"];
    }
    return nil;
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
