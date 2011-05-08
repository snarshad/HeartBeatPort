//
//  HBLoginViewController.m
//  HeartBeatPort
//
//  Created by Arshad Tayyeb on 5/7/11.
//  Copyright 2011 doubleTwist Corporation. All rights reserved.
//

#import "HBLoginViewController.h"
#import "HBUser.h"
#import "HBHomeViewController.h"
#import <Rdio/Rdio.h>
#import "RdioService.h"

@implementation HBLoginViewController

static HBLoginViewController *s_loginController = nil;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

+ (HBLoginViewController *)sharedLoginController
{
	return s_loginController;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	// Custom initialization.
	s_loginController = self;
	mUsernameField.hidden = YES;
	mPasswordField.hidden = YES;

	[mHomeViewController view];
    [super viewDidLoad];
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


- (void)dealloc {
	HBRelease(mService);
    [super dealloc];
}
#pragma mark -
- (IBAction)login
{
	//TODO: Validate Login
	//TODO: Set up the home view controller with actual user data

	mService = [[RdioService alloc] init];
	
	[mService user]; // this doesn't actually return anything... it kicks off the login and we get rdioDidAuthorizeUser callback instead. 
	
}

#pragma mark RdioDelegate
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken {	
	NSString *userName = [NSString stringWithFormat:@"%@ %@", [user valueForKey:@"firstName"], [user valueForKey:@"lastName"]];
	
	HBUser *rdioUser = [[HBUser alloc] initWithName:userName];
	[rdioUser.userData setObject:accessToken forKey:@"accessToken"];
	[rdioUser.userData addEntriesFromDictionary:user];
	
	if ([user valueForKey:@"icon"])
	{
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[user valueForKey:@"icon"]]];
		if (imageData)
		{
			UIImage *image = [UIImage imageWithData:imageData];
			if (image)
				rdioUser.avatar = image;
		}
		
	}
	
	[rdioUser.userData setObject:accessToken forKey:@"accessToken"];
	[rdioUser.userData addEntriesFromDictionary:user];
	mHomeViewController.user = rdioUser;
	[mService setUser:rdioUser];
	
	[self.navigationController pushViewController:mHomeViewController animated:YES];
}

/**
 * Authentication failed so we should alert the user.
 */
- (void)rdioAuthorizationFailed:(NSString *)message {
	NSLog(@"Rdio authorization failed: %@", message);
}


@end
