//
//  MTLSearchMovie.h
//  AMDb
//
//  Created by Mac Mini Beta on 29/12/16.
//  Copyright © 2016 Mac Mini Beta. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface MTLSearchMovie : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *posterURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) UIImage *moviePoster;


@end
