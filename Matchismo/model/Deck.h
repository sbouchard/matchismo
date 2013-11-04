//
//  Deck.h
//  Matchismo
//
//  Created by SBouchard on 10/24/2013.
//  Copyright (c) 2013 SBouchard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject



-(void) addCard:(Card*)card atTop:(BOOL)atTop;
-(Card*) drawRandomCard;

@end
