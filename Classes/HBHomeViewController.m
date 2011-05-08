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
@synthesize user=mMe, matcher = mMatcher, service = mService;

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

- (void)dealloc
{
	HBRelease(mService);
	HBRelease(mMe);
	HBRelease(mMatcher);
	[super dealloc];
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
- (void)setMatcher:(id <HBMatcherProtocol,HBServiceDelegate>)matcher
{
	[matcher retain];
	HBRelease(mMatcher);
	mMatcher = matcher;
	matcher.delegate = self;
}

#pragma mark -
- (IBAction)findMatches:(id)sender
{
	[mService setDelegate:mMatcher];
	[mService searchForNearbyUsers];
}

- (IBAction)showMyArtists:(id)sender
{
	
}

#pragma mark HBMatcherDelegate
- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatch:(HBUser *)user strength:(CGFloat)strength
{
	if (!mMatchedUsers)
	{
		mMatchedUsers = [[NSMutableDictionary alloc] initWithCapacity:10];
	}

	[mMatchedUsers setObject:user forKey:[NSNumber numberWithFloat:strength]];
}


- (void)matcher:(id<HBMatcherProtocol>)matcher foundMatches:(NSDictionary *)matches
{
	//TODO: Send notification here? allow viewing of users?
	
	NSLog(@"%d matches found!", matches.count);
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


@end
