//
//  SetCardView.m
//  Set
//
//  Created by H Calvin Flegal on 8/17/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "SetCardView.h"

#define FRACTION_SIZE_PER_SYMBOL .30
//height to width
#define SYMBOL_ASPECT_RATIO 2
#define STRIPE_SPACE 2.5
#define STROKE_WIDTH 4
#define CORNER_RADIUS 12
#define SELECTED_LINE_WIDTH 10

@interface SetCardView()

@property(nonatomic)CGFloat symbolWidth;
@property(nonatomic)CGFloat symbolHeight;
@property(nonatomic)CGFloat symbolSpacing;
@property(nonatomic)CGPoint myCenter;

@end
@implementation SetCardView

- (void)setup
{
    self.symbolWidth = self.bounds.size.width*FRACTION_SIZE_PER_SYMBOL;
    self.symbolHeight = self.symbolWidth*SYMBOL_ASPECT_RATIO;
    self.myCenter = CGPointMake(self.bounds.origin.x+self.bounds.size.width/2,
                                self.bounds.origin.y+self.bounds.size.height/2);
    self.symbolSpacing = .1*self.bounds.size.width;
    self.backgroundColor = [UIColor clearColor];
    
}
-(void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    [self setNeedsDisplay];
}
-(void)setCount:(NSUInteger)count {
    _count = count;
    [self setNeedsDisplay];
    
}
-(void)setTexture:(NSString *)texture {
    _texture = texture;
    [self setNeedsDisplay];
}
-(void)setShape:(NSString *)shape {
    _shape = shape;
    [self setNeedsDisplay];
}
-(void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

-(CGPoint)startingPointofSymbols {
    if (self.count ==1) {
        return CGPointMake(self.myCenter.x-.5*self.symbolWidth, self.myCenter.y-.5*self.symbolHeight);
    }
    else if (self.count ==2) {
        return CGPointMake(self.myCenter.x-self.symbolWidth, self.myCenter.y-.5*self.symbolHeight);
    }
    else {
        //three shapes
        return CGPointMake(self.myCenter.x-1.5*self.symbolWidth, self.myCenter.y-.5*self.symbolHeight);
    }
}
-(void)drawSquiggleInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGPoint ctl1 = CGPointMake(rect.origin.x+rect.size.width/2,rect.origin.y);
    CGPoint ctl2 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
    CGPoint arcStarttopRight = CGPointMake(rect.origin.x+.75*rect.size.width, rect.origin.y+rect.size.height*.1);
    CGPoint arcCtlpnt1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+.25*rect.size.height);
    CGPoint arcCtlpnt2 = CGPointMake(rect.origin.x+rect.size.width/2,rect.origin.y+.75*rect.size.height);
    CGPoint arcEndBotRight = CGPointMake(rect.origin.x+.75*rect.size.width,rect.origin.y+rect.size.height*.9);
    CGPoint arcStartBotLeft = CGPointMake(rect.origin.x+rect.size.width*.25, arcEndBotRight.y);
    CGPoint arcEndTopLeft = CGPointMake(arcStartBotLeft.x, arcStarttopRight.y);
    CGPoint arcCtlpnt3 = CGPointMake(rect.origin.x, arcCtlpnt2.y);
    CGPoint arcCtlpnt4 = CGPointMake(rect.origin.x+rect.size.width/2, arcCtlpnt1.y);
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path setLineWidth:STROKE_WIDTH];
    //set the color
    [self.color setStroke];
    [path moveToPoint:arcStarttopRight];
    [path addCurveToPoint:arcEndBotRight controlPoint1:arcCtlpnt1 controlPoint2:arcCtlpnt2];
    [path addQuadCurveToPoint:arcStartBotLeft controlPoint:ctl2];
    [path addCurveToPoint:arcEndTopLeft controlPoint1:arcCtlpnt3  controlPoint2:arcCtlpnt4];
    [path addQuadCurveToPoint:arcStarttopRight controlPoint:ctl1];
    [path addClip];
    [self fillSymbolwithRect:rect withPath:path];
    [path stroke];
    CGContextRestoreGState(context);
    
    //[path stroke];
    
}
-(void)drawOvalInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //set the color
    [self.color setStroke];
    //make a slightly padded rect...
    CGRect paddedRect = CGRectMake(rect.origin.x+.2*rect.size.width, rect.origin.y+rect.size.height*.1, rect.size.width*.6, rect.size.height*.8);
    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:paddedRect];
    [path setLineWidth:STROKE_WIDTH];
    //clip to the shape
    [path addClip];
    [self fillSymbolwithRect:rect withPath:path];
    [path stroke];
    CGContextRestoreGState(context);
}
-(void)drawDiamondInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path setLineWidth:STROKE_WIDTH];
    //set the color
    [self.color setStroke];
    //make a slightly padded rect...
    CGRect paddedRect = CGRectMake(rect.origin.x+.2*rect.size.width, rect.origin.y+rect.size.height*.1, rect.size.width*.6, rect.size.height*.8);
    
    [path moveToPoint:CGPointMake(paddedRect.origin.x+paddedRect.size.width/2, paddedRect.origin.y)];
    [path addLineToPoint:CGPointMake(paddedRect.origin.x+paddedRect.size.width, paddedRect.origin.y+paddedRect.size.height/2)];
    [path addLineToPoint:CGPointMake(paddedRect.origin.x+paddedRect.size.width/2,paddedRect.origin.y+paddedRect.size.height)];
    [path addLineToPoint:CGPointMake(paddedRect.origin.x, paddedRect.origin.y+paddedRect.size.height/2)];
    [path closePath];
    [path addClip];
    [self fillSymbolwithRect:rect withPath:path];
    [path stroke];
    CGContextRestoreGState(context);
}
-(void)fillSymbolwithRect:(CGRect)rect withPath:(UIBezierPath*)path {
    //since we added clip, its okay to fill entire rect
    if ([self.texture isEqualToString:@"solid"]) {
        [self.color setFill];
        [path fill];
    }
    else if ([self.texture isEqualToString:@"striped"]) {
        UIBezierPath* stripePath = [UIBezierPath bezierPath];
        for (int i=0; i<rect.size.width; i+= STRIPE_SPACE) {
            CGPoint topStart = CGPointMake(rect.origin.x+i, rect.origin.y);
            CGPoint botEnd = CGPointMake(rect.origin.x+i, rect.origin.y+rect.size.height);
            [stripePath moveToPoint:topStart];
            [stripePath addLineToPoint:botEnd];
        }
        [stripePath stroke];
    }
    else if ([self.texture isEqualToString:@"open"]) {
        return;
    }
    return;
}

-(void)drawShapeInRect:(CGRect)rect {
    if ([self.shape isEqualToString:@"squiggle"]) {
        [self drawSquiggleInRect:rect];
    }
    else if ([self.shape isEqualToString:@"diamond"]) {
        [self drawDiamondInRect:rect];
    }
    else if ([self.shape isEqualToString:@"oval"]) {
        [self drawOvalInRect:rect];
    }
    else {
        //NSlog problem
    }
    return;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    if (self.isSelected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        [roundedRect setLineWidth:SELECTED_LINE_WIDTH];
        [[UIColor blueColor] setStroke];
        [roundedRect stroke];
        
        CGContextRestoreGState(context);
        
        
    }
    else {
        [roundedRect stroke];
    }
    CGPoint p = [self startingPointofSymbols];
    for (int i=0; i<self.count; i++) {
      CGRect  rectToDrawIn = CGRectMake(p.x+i*self.symbolWidth,p.y,self.symbolWidth,
                                     self.symbolHeight);
        [self drawShapeInRect:rectToDrawIn];
    }
    
     return;
}



@end
