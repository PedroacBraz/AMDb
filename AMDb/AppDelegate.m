//
//  AppDelegate.m
//  AMDb
//
//  Created by Mac Mini Beta on 20/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import "AppDelegate.h"
#import "Movie.h"
#import "MoviesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSMutableArray *_movies;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _movies = [NSMutableArray arrayWithCapacity:20];
    
    Movie *movie = [[Movie alloc] init];
    movie.moviePoster = [UIImage imageNamed:@"posterArrival.jpg"];
    movie.title = @"Arrival";
    movie.year = @"2016";
    movie.rating = @"9.9";
    movie.shortSynopsis = @"ETs talking to some people";
    movie.fullSynopsis = @"ETs talking to some people. And it's really awesome. Feels like Inception";
    [_movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.moviePoster = [UIImage imageNamed:@"posterRogueOne.jpg"];
    movie.title = @"Rogue One";
    movie.year = @"2016";
    movie.rating = @"10.0";
    movie.shortSynopsis = @"I'm one with the Force. The Force is with me. I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.";
    movie.fullSynopsis = @"I'm one with the Force. The Force is with me. I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me.I'm one with the Force. The Force is with me. Gotta watch the other ones";
    [_movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.title = @"St. Cloverfield";
    movie.year = @"2016";
    movie.rating = @"1.0";
    movie.shortSynopsis = @"ETs killing some people";
    movie.fullSynopsis = @"ETs killing some people. Started nice.";
    [_movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.title = @"Civil War";
    movie.year = @"2016";
    movie.rating = @"8.0";
    movie.shortSynopsis = @"Avengers fight";
    movie.fullSynopsis = @"Avengers fight. Spider-man appears";
    [_movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.title = @"Arrival5";
    movie.year = @"2016";
    movie.rating = @"9.9";
    movie.shortSynopsis = @"ETs talking to some people12345";
    movie.fullSynopsis = @"ETs talking to some people12345. And it's really awesome. Feels like Inception";
    [_movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.title = @"Arrival6";
    movie.year = @"2016";
    movie.rating = @"7.9";
    movie.shortSynopsis = @"ETs talking to some people12345678";
    movie.fullSynopsis = @"ETs talking to some people12345678. And it's really awesome. Feels like Inception";
    [_movies addObject:movie];

    //Gets the Navigatin controller on the root
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    //Gets the moviesViewController in the first index of the navigator controller
    MoviesViewController *moviesViewController = [navigationController viewControllers][0];
    
    moviesViewController.movies = _movies;
                                                    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
