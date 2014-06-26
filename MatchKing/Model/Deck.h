//
//  Deck.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

/*
 * Class models a generic deck containing cards.
 *
 */

@interface Deck : NSObject

// Allows cards to be added to deck
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

// Draw random card from deck
- (Card *)drawRandomCard;

@end
