//
//  QBBaseViewController.m
//  KeyBoardHandler
//
//  Created by Sakkeer on 26/02/16.
//  Copyright © 2016 Sample. All rights reserved.
//

#import "QBBaseViewController.h"

@interface QBBaseViewController ()

@property (strong, nonatomic) UITapGestureRecognizer * tapRecognizer;

@end

@implementation QBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma handle keyboard
-(void) handleKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(didTapAnywhere:)];
}

-(void) keyboardWillShow:(NSNotification *) notification {
    [self.view layoutIfNeeded];
    
    [self.view addGestureRecognizer:self.tapRecognizer];
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    _bottomMarginConstraint.constant = keyboardRect.size.height;
    [UIView animateWithDuration:5
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
}

-(void) keyboardWillHide:(NSNotification *) notification {
    [self.view layoutIfNeeded];
    [self.view removeGestureRecognizer:self.tapRecognizer];
    _bottomMarginConstraint.constant = 0;
    [UIView animateWithDuration:5
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [[self.view window] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
