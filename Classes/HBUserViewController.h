//
//  HBUserViewController.h
//  HeartBeatPort
//
//  Created by Daniel DeCovnick on 5/7/11.
//  Copyright 2011 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBUser, HBMessageViewController;

@interface HBUserViewController : UIViewController {
	IBOutlet UIImageView *mUserImageView;
	
	IBOutlet UILabel *mUserName;	
	HBUser *mUser;
	IBOutlet UILabel *mCommonArtists;
	IBOutlet UILabel *mGenderLabel;
	IBOutlet UILabel *mSeekingLabel;
	IBOutlet UILabel *mScoreLabel;
	HBMessageViewController *mMessageController;
}
@property (nonatomic, retain) HBUser *user;
@property (nonatomic, retain) NSArray *commonArtists;
- (IBAction)message:(id)sender;
- (IBAction)meet:(id)sender;
- (IBAction)decline:(id)sender;
@end
