//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by SBouchard on 11/3/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *lastAction;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic) NSUInteger numberOfCardsToMatch;
@end


@implementation CardMatchingGame

-(NSMutableArray *) cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck*)deck{
    
    self = [super init];
    if(self){
        for(int i=0;i<count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }else{
                self = nil;
                break;
            }
        }
    }
    
    self.numberOfCardsToMatch = 2;
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void) flipCardAtIndex:(NSUInteger) index{
    
    Card* card = [self cardAtIndex:index];
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            self.lastAction = [NSString stringWithFormat:@"Flipped up %@",card.contents];
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        int score = matchScore * MATCH_BONUS;
                        self.score += score;
                        self.lastAction = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card.contents, otherCard.contents, score];
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastAction = [NSString stringWithFormat:@"%@ and %@ don't match! %D point penalty!",card.contents, otherCard.contents, MISMATCH_PENALTY];

                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
            
        }
        
        card.faceUp = !card.isFaceUp;
    }

}


-(Card*) cardAtIndex:(NSUInteger) index{
    Card* card;
    
    if(index < [self.cards count] ){
        card = self.cards[index];
    }
    
    return card;
}





@end
