//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by SBouchard on 11/3/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (readonly, nonatomic)int score;
@property (readonly, nonatomic)NSString *lastAction;

// Designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck*)deck;

-(void) flipCardAtIndex:(NSUInteger) index;
-(Card*) cardAtIndex:(NSUInteger) index;

@end
