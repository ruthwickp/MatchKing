//
//  CardGameViewController.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

/**
 * Class provides a card matching game that can modified 
 * to play different games.
 *
 */

@interface CardGameViewController : UIViewController

// Card matching game property
@property (strong, nonatomic) CardMatchingGame *game;


// Abstract Methods

- (void)updateUI;

// Get number of cards and deck for game
- (int)getNumberOfCards;
- (Deck *)createDeck;


@end
