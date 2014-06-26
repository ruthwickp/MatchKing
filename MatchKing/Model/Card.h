//
//  Card.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Class models a generic card used for any matching game.
 *
 */

@interface Card : NSObject

// Contains the contents of a card
@property (strong, nonatomic) NSString *contents;

// Stores chosen and match status of a card
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

// Matches other cards and returns a score depending of how well
// the card was matched.
- (int)match:(NSArray *)otherCards;

@end
