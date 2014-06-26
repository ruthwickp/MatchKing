//
//  SetCard.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

/**
 * Overriden method matches cards based on the rules of Set.
 *
 * @param   otherCards -- cards to be matched
 * @return  score on how well the cards matched
 *
 */
- (int)match:(NSArray *)otherCards
{
    int matchscore = 0;
    
    // Checks array for two set cards
    if ([otherCards count] == 2) {
        id card1 = otherCards[0];
        id card2 = otherCards[1];
        if ([card1 isKindOfClass:[SetCard class]] && [card2 isKindOfClass:[SetCard class]]) {
            SetCard *firstCard = (SetCard *)card1;
            SetCard *secondCard = (SetCard *)card2;
            
            // Check for matched numbers, symbols, shading, and colors
            if ([self matchNumbers:firstCard andMatch:secondCard] &&
                [self matchSymbols:firstCard andMatch:secondCard] &&
                [self matchShadings:firstCard andMatch:secondCard] &&
                [self matchColors:firstCard andMatch:secondCard]) {
                matchscore = 4;
            }
        }
    }
    return matchscore;
}


#pragma mark - Matching Methods

/**
 * Matching methods return true is all three cards share the same
 * property or if none of the cards share the same property.
 *
 */

- (BOOL)matchNumbers:(SetCard *)firstCard andMatch:(SetCard *)secondCard
{
    if (self.number == firstCard.number) {
        if (self.number == secondCard.number) {
            return true;
        }
    }
    else if (self.number != secondCard.number) {
        if (firstCard.number != secondCard.number) {
            return true;
        }
    }
    return false;
}

- (BOOL)matchSymbols:(SetCard *)firstCard andMatch:(SetCard *)secondCard
{
    if ([self.symbol isEqualToString:firstCard.symbol]) {
        if ([self.symbol isEqualToString:secondCard.symbol]) {
            return true;
        }
    }
    else if (![self.symbol isEqualToString:secondCard.symbol]) {
        if (![firstCard.symbol isEqualToString:secondCard.symbol]) {
            return true;
        }
    }
    return false;
}

- (BOOL)matchShadings:(SetCard *)firstCard andMatch:(SetCard *)secondCard
{
    if ([self.shading isEqualToString:firstCard.shading]) {
        if ([self.shading isEqualToString:secondCard.shading]) {
            return true;
        }
    }
    else if (![self.shading isEqualToString:secondCard.shading]) {
        if (![firstCard.shading isEqualToString:secondCard.shading]) {
            return true;
        }
    }
    return false;
}

- (BOOL)matchColors:(SetCard *)firstCard andMatch:(SetCard *)secondCard
{
    if ([self.color isEqualToString:firstCard.color]) {
        if ([self.color isEqualToString:secondCard.color]) {
            return true;
        }
    }
    else if (![self.color isEqualToString:secondCard.color]) {
        if (![firstCard.color isEqualToString:secondCard.color]) {
            return true;
        }
    }
    return false;
}



#pragma mark - Validate Setters

/**
 * Makes sure properties of set card contain valid values.
 *
 */

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setNumber:(NSUInteger)number
{
    if ((1 <= number) && (number <= 3)) {
        _number = number;
    }
}



#pragma mark - Class Methods

/**
 * Returns valid properties for each category.
 *
 */
 
+ (NSArray *)validSymbols
{
    return @[@"squiggle", @"diamond", @"ovals"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}


@end
