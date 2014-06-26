//
//  Deck.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()

// Contains array of cards which models the deck
@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck


/*
 * Makes sure card array is initialized.
 *
 */
- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

/*
 * Adds a card to the deck, either at the top or to the end.
 *
 * @param   card -- card to be added
 * @param   atTop -- whether the card is to be added to the top or not
 *
 */
- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

/*
 * Adds the card to the end of the deck.
 *
 * @param   card -- card to added
 *
 */
- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

/*
 * Draws a random card from deck. If the deck is empty, a nil card is returned.
 * The drawn card is deleted from deck.
 *
 * @return  card that was drawn
 *
 */
- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
