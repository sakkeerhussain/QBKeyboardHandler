//
//  QBBaseViewController.h
//  KeyBoardHandler
//
//  Created by Sakkeer on 26/02/16.
//  Copyright © 2016 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBBaseViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMarginConstraint;

@end
