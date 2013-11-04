//
//  PlayingCard.m
//  Matchismo
//
//  Created by SBouchard on 10/24/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(int)match:(NSArray*)otherCards{
    
    int score = 0;
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }else if(otherCard.rank == self.rank){
            score = 4;
        }
        
    }else if ([otherCards count] == 2) {
        id firstCard = [otherCards objectAtIndex:0];
        id secondCard = [otherCards objectAtIndex:1];
        
        if ([firstCard isKindOfClass:[PlayingCard class]] &&
            [secondCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *firstPlayingCard = (PlayingCard *)firstCard;
            PlayingCard *secondPlayingCard = (PlayingCard *)secondCard;
            
            if ([firstPlayingCard.suit isEqualToString:self.suit] && [secondPlayingCard.suit isEqualToString:self.suit]) {
                score = 4;
            } else if ((firstPlayingCard.rank == self.rank) && (secondPlayingCard.rank == self.rank)) {
                score = 16;
            }
        }
    }
    
    return score;
    
}



-(NSString*) contents{
    
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


+(NSArray*) validSuits{
    return @[@"♥︎", @"♣︎", @"♦︎", @"♠︎"];
}


+(NSArray*) rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

-(void) setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString*) suit{
    return _suit ? _suit : @"?";
}

+(NSInteger)maxRank{
    return [self rankStrings].count-1;
}

-(void)setRank:(NSInteger)rank{
    
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}


@end
