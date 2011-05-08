//
//  HBHomeViewController.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBHomeViewController.h"
#import "HBUser.h"

@implementation HBHomeViewController
@synthesize user=mMe, serviceName = mServiceName;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		NSLog(@"initWithNibNamed %@", nibNameOrNil );
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"did load %@, %@", mUserName, mUserImageView);
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark -

#pragma mark -
- (void)setUser:(HBUser *)myUser
{
	[myUser retain];
	HBRelease(mMe);
	mMe = myUser;
	NSLog(@"Set User %@, %@", mUserName, mUserImageView);
	
	[mUserName setText:mMe.userName];
	[mUserImageView setImage:mMe.avatar];
}


#pragma mark -
- (IBAction)findMatches:(id)sender
{
	
}

- (IBAction)showMyArtists:(id)sender
{
	
}

#pragma mark -

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


- (void)dealloc {
    [super dealloc];
}


@end
