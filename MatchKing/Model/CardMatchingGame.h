//
//  CardMatchingGame.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/26/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

/**
 * Models describes a card matching game. Initializes a deck of cards
 * and allows users to choose cards and provides score.
 *
 */

@interface CardMatchingGame : NSObject

// Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

// Allows cards to be chosen and retrieved
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// Add more cards
- (void)addMoreCards:(NSUInteger)numberOfCards;

// Number of cards in play
@property (nonatomic, readonly) NSUInteger cardsInPlay;

// Score of matching game
@property (nonatomic, readonly) NSInteger score;

// Two different card matching games
@property (nonatomic) BOOL setCardMode;
@property (nonatomic) BOOL playingCardMode;



@end
