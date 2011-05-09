//
//  HBUserViewController.m
//  HeartBeatPort
//
//  Created by Daniel DeCovnick on 5/7/11.
//  Copyright 2011 Softyards Software. All rights reserved.
//

#import "HBUserViewController.h"
#import "HBMessageViewController.h"
#import "HBUser.h"


@implementation HBUserViewController
@synthesize user = mUser;

- (NSArray *)commonArtists
{
	return [mCommonArtists.text componentsSeparatedByString:@"\n"];
}
- (void)setCommonArtists:(NSArray *)artists
{
	mCommonArtists.text = [artists componentsJoinedByString:@"\n"];
}
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
	
	
	self.commonArtists = [mUser.userData valueForKey:@"commonArtists"];
	
	int max = 3;
	if (self.commonArtists.count < 3)
	{
		max = self.commonArtists.count;
	}
	mCommonArtists.numberOfLines = max;
	//self.commonArtists = [[mUser artistList] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, max)]];

	
	mUserName.text = mUser.userName;
	mUserImageView.image = [mUser getAvatar];
	mUser.delegate = self;
	mGenderLabel.text = mUser.gender;
	mSeekingLabel.text = [mUser.gender isEqualToString:@"Male"]?@"Female":@"Male";
	mScoreLabel.text = [mUser.userData objectForKey:@"strength"]?[[mUser.userData objectForKey:@"strength"] stringValue]:@"Unkown";
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
    [super dealloc];
}
- (IBAction)decline:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)meet:(id)sender
{
	//TODO: implement
}
- (IBAction)message:(id)sender
{
	HBRelease(mMessageController);
	mMessageController = [[HBMessageViewController alloc] initWithNibName:@"HBMessageViewController" bundle:nil];
	[self.navigationController pushViewController:mMessageController animated:YES];
}

- (void)avatarRetrieved:(HBUser *)user
{
	if (user == mUser)
	{
		[mUserImageView setImage:[user getAvatar]];
	}
}

@end
