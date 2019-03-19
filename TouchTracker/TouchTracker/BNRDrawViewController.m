//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Tawhid Joarder on 3/19/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@interface BNRDrawViewController ()

@end

@implementation BNRDrawViewController

-(void)loadView{
    self.view = [[BNRDrawView alloc]init];
}


@end
