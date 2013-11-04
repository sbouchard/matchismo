//
//  PlayingCard.h
//  Matchismo
//
//  Created by SBouchard on 10/24/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card


@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;


+(NSArray*)validSuits;
+(NSInteger)maxRank;
+(NSArray*) rankStrings;

@end
