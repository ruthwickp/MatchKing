//
//  SetCardDeck.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

/**
 * Overrides init method by adding 81 Set cards to the deck.
 *
 * @return  object instance of class
 *
 */
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (int i = 1; i <= 3; i++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSString *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = i;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }    
    return self;
}

@end
