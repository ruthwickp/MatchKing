//
//  CardMatchingGame.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/26/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame()

// Keeps track of score of the game
@property (nonatomic, readwrite) NSInteger score;

// Store number of cards in play
@property (nonatomic, readwrite) NSUInteger cardsInPlay;

// Cards in the game
@property (nonatomic, strong) NSMutableArray *cards;

// Deck used for game
@property (nonatomic, strong) Deck *deck;

@end

@implementation CardMatchingGame

/**
 * Designated initializer starts game with some number of
 * cards from the deck.
 *
 * @param   count -- number of cards in matching game
 * @param   deck -- deck from which cards are used
 *
 * @return  CardMatchingGame object
 *
 */
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        // Fills up the array with count number of cards from deck
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            // We break if deck doesn't contain enough cards
            else {
                self = nil;
                break;
            }
        }
    }
    self.cardsInPlay = count;
    self.deck = deck;
    
    return self;
}



/**
 * Make sure cards are initialized before used.
 *
 * @return  array that contains the cards
 *
 */
- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


#pragma mark - Card Methods

/**
 * Returns card at given index. If index not in range, returns nil.
 *
 * @param   index -- location of card
 *
 * @return  card at designated index location
 *
 */
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <= [self.cards count]) ? self.cards[index] : nil;
}

// Extra points indicated for matching
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

/**
 * Chooses a card at the index and determines if there is a matching
 * or not and updates score.
 *
 * @param   index -- location of chosen card
 *
 */
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        // Toggle card if it is already chosen
        if (card.isChosen) {
            card.chosen = NO;
        }
        
        // Match against other non-matched, chosen cards
        else {
            // Stores non-matched, chosen cards
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen) {
                    [otherCards addObject:otherCard];
                }
            }
            
            // If in playingCardMode and found another card
            if (self.playingCardMode && [otherCards count] == 1) {
                Card *otherCard = [otherCards firstObject];
                int matchScore = [card match:otherCards];
                
                // If matched, update score and cards
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    otherCard.matched = YES;
                    card.matched = YES;
                    self.cardsInPlay -= 2;
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                }
                
            }
            
            // If in setCardMode and found two cards
            else if (self.setCardMode && [otherCards count] == 2) {
                Card *firstCard = otherCards[0];
                Card *secondCard = otherCards[1];
                int matchScore = [card match:otherCards];
                
                // If matched, update score and cards
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    firstCard.matched = YES;
                    secondCard.matched = YES;
                    self.cardsInPlay -= 3;
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    firstCard.chosen = NO;
                    secondCard.chosen = NO;
                }
            }
                        
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

/**
 * Adds number of cards to game and increases cards in play.
 *
 * @param   numberOfCards -- number of cards to add
 *
 */
- (void)addMoreCards:(NSUInteger)numberOfCards
{
    // Adds cards
    for (int i = 0; i < numberOfCards; i++) {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        }
        else {
            return;
        }
    }
    
    // Only increments when all cards are successfully added
    self.cardsInPlay += numberOfCards;
}

@end
