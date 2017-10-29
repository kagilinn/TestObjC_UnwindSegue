//
//  RollingUnwindSegue.m
//  TestObjC_UnwindSegue
//
//  Created by Toshiya Yoshida on 2017/10/29.
//  Copyright © 2017年 kagilinn. All rights reserved.
//

#import "RollingUnwindSegue.h"

@implementation RollingUnwindSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
							source:(UIViewController *)source
					   destination:(UIViewController *)destination
{
	self = [super initWithIdentifier:identifier
							  source:source
						 destination:destination];
	return self;
}

- (void)perform {
	__weak typeof(self) weak_self = self;
	CGSize size = UIScreen.mainScreen.bounds.size;
	[UIApplication.sharedApplication.keyWindow
		insertSubview:self.destinationViewController.view
		 belowSubview:self.     sourceViewController.view];
	self.destinationViewController.view.frame
		= CGRectMake(-size.width, 0, size.width, size.height);
	[UIView animateWithDuration:0.375f
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
		animations:^{
			UIView *src  = weak_self.     sourceViewController.view;
			UIView *dest = weak_self.destinationViewController.view;
			dest.frame = CGRectMake(0, 0, size.width, size.height);
			src .frame = CGRectOffset(dest.frame, size.width, 0);
		} completion:^(BOOL finished) {
			@autoreleasepool {
				UIViewController *src = weak_self.sourceViewController;
				[src dismissViewControllerAnimated:NO
										completion:nil];
			}
		}
	];
}

@end
