//
//  askViewController.m
//  Kitchen Sink
//
//  Created by Tongda Zhang on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "askViewController.h"

@interface askViewController() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerQuestionField;
@end

@implementation askViewController
@synthesize questionLabel = _questionLabel;
@synthesize answerQuestionField = _answerQuestionField;
@synthesize delegate=_delegate;
@synthesize question=_question;
@synthesize answer=_answer;

-(void)setQuestion:(NSString *)question{
    _question = question;
    self.questionLabel.text = question;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.questionLabel.text=self.question;
    self.answerQuestionField.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.answerQuestionField becomeFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.answer = textField.text;
    if(![textField.text length]){
        [[self presentingViewController] dismissModalViewControllerAnimated:YES];
    }else{
        [self.delegate askerViewController:self didAskQuestion:self.question andGotAnswer:self.answer];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text length]) {
        [textField resignFirstResponder];
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)viewDidUnload {
    [self setQuestionLabel:nil];
    [self setAnswerQuestionField:nil];
    [super viewDidUnload];
}
@end
