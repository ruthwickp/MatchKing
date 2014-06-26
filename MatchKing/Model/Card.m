//
//  Card.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "Card.h"


@implementation Card

/**
 * Method that checks if the card matches any one of the other cards.
 *
 * @param   otherCards -- array of other cards being checked
 *
 * @return  integer indicating how well the matching was.
 *
 */
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
