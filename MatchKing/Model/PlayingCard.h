//
//  PlayingCard.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "Card.h"

/*
 * Class describes a playing card having a suit and rank as contents.
 *
 */

@interface PlayingCard : Card

// Suit and rank of playing card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

// Returns valid suits of playing card
+ (NSArray *)validSuits;

// Return maximum rank of playing cards
+ (NSUInteger)maxRank;


@end
