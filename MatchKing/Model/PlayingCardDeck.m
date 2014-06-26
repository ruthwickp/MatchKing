//
//  PlayingCardDeck.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

/**
 * Overriding init method by adding a playing cards to the playing
 * card deck.
 *
 * @return the specific instance type that is initialized.
 *
 */
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // Fills deck up with all 52 playing cards
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
