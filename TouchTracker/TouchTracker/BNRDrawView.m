//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Tawhid Joarder on 3/19/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNLine.h"
@interface BNRDrawView()
@property (nonatomic,strong)NSMutableDictionary *lineInProgress;
@property (nonatomic,strong)NSMutableArray *finishedLines;
@end
@implementation BNRDrawView
-(instancetype)initWithFrame:(CGRect)r{
    self = [super initWithFrame:r];
    if(self){
        self.lineInProgress = [[NSMutableDictionary alloc]init];
        self.finishedLines = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor whiteColor];
        self.multipleTouchEnabled = YES ;
        
    }
    return self ;
}
-(void)strokeLine:(BNLine *)line{
    UIBezierPath *bp= [UIBezierPath bezierPath];
    bp.lineWidth = 10 ;
    bp.lineCapStyle = kCGLineCapRound;
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}
-(void)drawRect:(CGRect)rect{
    [[UIColor blackColor]set];
    for(BNLine *line in self.finishedLines){
        [self strokeLine:line];
    }
    [[UIColor redColor]set];
    for(NSValue *key in self.lineInProgress){
        [self strokeLine:self.lineInProgress[key]];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for( UITouch *t in touches){
        CGPoint location = [ t locationInView:self];
        BNLine *line =[ [BNLine alloc] init ];
        line.begin = location ;
        line.end = location ;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.lineInProgress [key] = line ;
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNLine *line = self.lineInProgress[key];
        line.end = [ t locationInView:self];
    }
    [ self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for( UITouch *t in touches){
        NSValue *key = [ NSValue valueWithNonretainedObject:t];
        BNLine *line = self.lineInProgress[key];
        [self.finishedLines addObject:line];
        [self.lineInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
@end

