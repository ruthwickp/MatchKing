//
//  PlayingCardGameViewController.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/26/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardView.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

// Contains all views
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardsCollection;

@end

@implementation PlayingCardGameViewController

// Sets mode for card matching game
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.game.playingCardMode = YES;
}

- (IBAction)tapCard:(UITapGestureRecognizer *)sender {
}

- (void)updateUI
{
    for (PlayingCardView *playingCardView in self.playingCardsCollection) {
        if (playingCardView)
    }
}

// Get number of cards and deck for game
- (int)getNumberOfCards
{
    
}


- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
