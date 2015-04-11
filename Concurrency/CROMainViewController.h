//
//  CROMainViewController.h
//  Concurrency
//
//  Created by Jose Manuel Franco on 11/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CROMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)syncDownload:(id)sender;
- (IBAction)asyncDownload:(id)sender;
- (IBAction)asyncDownloadPro:(id)sender;

@end
