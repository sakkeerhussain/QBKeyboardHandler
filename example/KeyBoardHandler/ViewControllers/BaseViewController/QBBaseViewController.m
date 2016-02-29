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
@property (strong, nonatomic) NSArray* allTextFields;

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
    
    if (textField.returnKeyType == UIReturnKeyNext) {
        if (_allTextFields == nil) {
            _allTextFields = [self findAllTextFieldsInView:[self view]];
        }
        
        for (int i=0; i<_allTextFields.count; i++) {
            UITextField * iTextField = _allTextFields[i];
            if (textField == iTextField) {
                if (i+1 == _allTextFields.count) {
                    [_allTextFields[0] becomeFirstResponder];
                }else{
                    [_allTextFields[i+1] becomeFirstResponder];
                }
            }
        }
    }
    
    return YES;
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}


@end
