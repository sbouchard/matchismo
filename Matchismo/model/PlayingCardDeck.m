//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by SBouchard on 10/24/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck


-(id)init{
    
    self = [super init];
    if(self){
        for(NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank=1;rank<= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:true];
            }
        }
    }
    
    
    return self;
    
}

@end
