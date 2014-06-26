//
//  PlayingCard.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

# pragma mark - Matching Cards

/*
 * Overriden method that computes the matching score with one other card.
 *
 * @param   otherCards -- array containing other card objects
 *
 * @return  integer representing match score
 *
 */
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // Matches one card given by array
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            
            // If rank or suit is matched, assign score
            if (otherCard.rank == self.rank) {
                score = 4;
            }
            else if ([otherCard.suit isEqualToString:self.suit]) {
                score = 1;
            }
        }
    }
    return score;
}

#pragma mark - Getters and Setters

/* Included this since getter and setter methods were changed */
@synthesize suit = _suit;

/*
 * Getter method for contents that returns a string containing a rank
 * and suit.
 *
 * @return  a string containing a rank and suit
 *
 */
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

/*
 * Setter method of suits make sure valid suits are set to the property.
 *
 * @param   string containing a suit
 *
 */
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

/*
 * Assigns a special character if the suit is empty.
 *
 * @return  a string containing the specific character for suit
 *
 */
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

/*
 * Makes sure rank is within range.
 *
 * @param   rank -- integer for setting the rank
 *
 */
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



#pragma mark - Class Methods

/*
 * Returns an array of strings that match to the rank of playing cards.
 * Index at 0 location is a question mark character.
 *
 * @return  array of strings matching playing cards
 *
 */
+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

/*
 * Returns an integer indicating the range of the array.
 *
 * @return  integer for range of string
 *
 */
+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

/*
 * Returns an array of valid suits.
 *
 * @return  an array of valid suit characters
 *
 */
+ (NSArray *)validSuits
{
    return @[@"♠️", @"♥️", @"♣️", @"♦️"];
}


@end
