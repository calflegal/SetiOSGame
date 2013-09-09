//
//  RemainingSetsViewController.m
//  Set
//
//  Created by H Calvin Flegal on 9/5/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "RemainingSetsViewController.h"
#import "SetCardView.h"

@interface RemainingSetsViewController ()

@end

@implementation RemainingSetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood2.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
