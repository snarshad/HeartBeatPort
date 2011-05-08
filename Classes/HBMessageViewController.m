//
//  HBMessageViewController.m
//  HeartBeatPort
//
//  Created by Daniel DeCovnick on 5/8/11.
//  Copyright 2011 Softyards Software. All rights reserved.
//

#import "HBMessageViewController.h"


@implementation HBMessageViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Compose Message";
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp:) name:UIKeyboardDidShowNotification object:nil];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)keyboardUp:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
	CGRect newRect;
	newRect.size = mAttachView.frame.size;
	newRect.origin.x = mAttachView.frame.origin.x;
	newRect.origin.y = mAttachView.frame.origin.y - kbSize.height;
	[mAttachView setFrame:newRect];
	// If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
}


- (void)dealloc {
    [super dealloc];
}


@end
