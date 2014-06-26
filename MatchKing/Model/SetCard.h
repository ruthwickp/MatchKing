//
//  SetCard.h
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/25/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "Card.h"

/*
 * Models a set card which has a number (1, 2, 3), symbol (diamond, 
 * ovals, squiggles), shading (solid, striped, open), and color (red,
 * green, purple).
 *
 */

@interface SetCard : Card

// Contents of set card
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

// Valid properties of Set card
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
