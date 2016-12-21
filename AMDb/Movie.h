//
//  Movie.h
//  AMDb
//
//  Created by Mac Mini Beta on 21/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
    
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) int year;
@property (nonatomic, assign) float rating;
@property (nonatomic, copy) NSString *shortSynopsis;
@property (nonatomic, copy) NSString *fullSynopsis;
    

@end
