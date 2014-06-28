//
//  CardGameViewController.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

// Score label outlet for game
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

/**
 * Makes sure game is initialized.
 *
 * @return  CardMatchingGame object
 *
 */
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self getNumberOfCards]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}


#pragma mark - UI Tasks

/**
 * Reset game and updates UI
 *
 */
- (IBAction)resetGameButton:(UIButton *)sender
{
    self.game = nil;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    [self updateUI];
    
}

/**
 * Abstract method updates UI
 *
 */
- (void)updateUI {}


#pragma mark - Game Settings

/**
 * Abstract method returns number of cards needed for game.
 *
 * @return  number of cards for game
 *
 */
- (int)getNumberOfCards
{
    return 0;
}

/**
 * Abstract method returns card deck for game.
 *
 * @return  deck for game
 */
- (Deck *)createDeck
{
    return nil;
}



@end
