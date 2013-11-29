//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by SBouchard on 11/3/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *lastAction;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (nonatomic, readwrite) Card* lastFlippedCard;
@property (nonatomic, readwrite) NSArray* lastMatchedCards;
@property (nonatomic) NSMutableArray* cardsInMatchQueue;
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

-(id)initWithCardCount:(NSUInteger)count
andNumberOfCardToMAtch:(NSUInteger)nbrCard
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
    
    self.numberOfCardsToMatch = nbrCard;
    return self;
}



-(void) flipCardAtIndex:(NSUInteger) index{
    
    Card *card = [self cardAtIndex:index];
    self.lastFlippedCard = nil;
    self.lastMatchedCards = nil;

    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastAction = [NSString stringWithFormat:@"Flipped up %@",card.contents];
            self.lastFlippedCard = card;
            [self.cardsInMatchQueue addObject:card];
            if ([self.cardsInMatchQueue count] == self.numberOfCardsToMatch) {
                [self finalizeTurnScore];
            }
        } else {
            [self.cardsInMatchQueue removeObject:card];
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


- (NSMutableArray *)cardsInMatchQueue {
    if(!_cardsInMatchQueue) _cardsInMatchQueue = [[NSMutableArray alloc] init];
    
    return _cardsInMatchQueue;
}




- (void)finalizeTurnScore {
    self.lastMatchedCards = [self.cardsInMatchQueue copy];
    
    Card* card = [self.cardsInMatchQueue lastObject];
    [self.cardsInMatchQueue removeLastObject];
    NSString *cards = @"";
    
    int matchScore = [card match:self.cardsInMatchQueue];
    if (matchScore) {
        
        for (Card* otherCard in self.cardsInMatchQueue) {
            otherCard.unplayable = YES;
            cards = [cards stringByAppendingString:otherCard.contents];
            cards = [cards stringByAppendingString: @" & "];
        }
        card.unplayable = YES;
        cards = [cards stringByAppendingString:card.contents];
        self.cardsInMatchQueue = nil;
        self.lastAction = [NSString stringWithFormat:@"Matched %@ for %d points",cards, matchScore];
    } else {
        for (Card* otherCard in self.cardsInMatchQueue) {
            otherCard.faceUp = NO;
            cards = [cards stringByAppendingString:otherCard.contents];
            cards = [cards stringByAppendingString: @" & "];
        }
        self.cardsInMatchQueue = nil;
        cards = [cards stringByAppendingString:card.contents];
        [self.cardsInMatchQueue addObject:card];
        self.lastAction = [NSString stringWithFormat:@"%@ don't match!",cards];
        
        
    }
    
    
    
    self.score += matchScore;
}


@end
