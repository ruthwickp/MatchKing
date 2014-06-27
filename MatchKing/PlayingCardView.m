//
//  PlayingCardView.m
//  MatchKing
//
//  Created by Ruthwick Pathireddy on 6/26/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#pragma mark - Properties

// Redraws if something gets set
- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}


#pragma mark - Drawing

// Constants dealing with drawing
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }



/**
 * Draws custom playing card on the view.
 *
 */
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    // Prevents drawing outside path
    [roundedRect addClip];
    
    // Fills background of view with white
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    // Outlines the card
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.faceUp) {
        // Draw corners and faces
        [self drawCorners];
        [self drawFace];
    }
    else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

/**
 * Returns rank as string.
 *
 * @return  string representation of rank
 *
 */
- (NSString *)rankAsString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

/**
 * Draws corners of the card.
 *
 */
- (void)drawCorners
{
    // Centers the text
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    // Set font
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    // Create corner text for card
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{ NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle }];
    
    // Creates rectangle to draw card in top left corner text
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    // Draws rectangle in bottom right corner
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
    
}

#define FACE_CARD_SCALE_FACTOR .9
/**
 * Draws face image on card if found.
 *
 */
- (void)drawFace
{
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    if (faceImage) {
        CGRect imageRect = CGRectInset(self.bounds,
                                       self.bounds.size.width * (1.0 - FACE_CARD_SCALE_FACTOR),
                                       self.bounds.size.height * (1.0 - FACE_CARD_SCALE_FACTOR));
        [faceImage drawInRect:imageRect];
    }

}



#pragma mark - Initialization

// Sets the view background to nil and redraws it if size changes
- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

// Sets up the view in storyboard
- (void)awakeFromNib
{
    [self setup];
    self.rank = 13;
    self.suit = @"♥️";
    self.faceUp = YES;
    
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
