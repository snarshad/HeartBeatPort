//
//  HBUserViewController.h
//  HeartBeatPort
//
//  Created by Daniel DeCovnick on 5/7/11.
//  Copyright 2011 Softyards Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBUser;

@interface HBUserViewController : UIViewController {
	IBOutlet UIImageView *mUserImageView;
	
	IBOutlet UILabel *mUserName;	
	HBUser *mUser;
	IBOutlet UITextView *mCommonArtists;
}
@property (nonatomic, retain) HBUser *user;
@property (nonatomic, retain) NSArray *commonArtists;
@end
