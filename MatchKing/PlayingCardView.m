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

#define FACE_CARD_SCALE_FACTOR .80
/**
 * Draws face image on card if found.
 *
 */
- (void)drawFace
{
    // If face image is available
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    if (faceImage) {
        CGRect imageRect = CGRectInset(self.bounds,
                                       self.bounds.size.width * (1.0 - FACE_CARD_SCALE_FACTOR),
                                       self.bounds.size.height * (1.0 - FACE_CARD_SCALE_FACTOR));
        [faceImage drawInRect:imageRect];
    }
    else {
       [self drawPips];
    }

}

#define PIP_FONT_SCALE_FACTOR 0.20
#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

/**
 * Draws pips on view.
 *
 */
- (void)drawPips
{
    if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
    }
    if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
    }
    if ((self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
    }
}

/**
 * Draw pips in certain locations.
 *
 */
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
    if (upsideDown) [self pushContextAndRotateUpsideDown];
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont }];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(
                                    middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                    );
    [attributedSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) [self popContext];
}

// Draw pips in mirrored state
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset
                                upsideDown:YES];
    }
}

// Rotates current context
- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

// Gets current context
- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
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
    self.rank = 10;
    self.suit = @"♥️";
    self.faceUp = YES;
    
}

// Sets the frame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end
