//
//  Movie.h
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>


@interface Movie : NSObject

// Movie's attributes

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *shortSynopsis;
@property (nonatomic, copy) NSString *fullSynopsis;
@property (nonatomic, copy) UIImage *moviePoster;

- (Movie *) initWithDictionary:(NSDictionary *)movieDictionary;

@end
