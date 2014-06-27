//
//  PlayingCardView.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/26/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * View draws a playing card with a suit and rank as contents
 *
 */
@interface PlayingCardView : UIView

// Rank and suit of card
@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;

// Whether it is face up or not
@property (nonatomic) BOOL faceUp;

@end
