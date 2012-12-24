//
//  NoteViewController.m
//  WhateverNote
//
//  Created by Levey on 12/21/12.
//  Copyright (c) 2012 SlyFairy. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation NoteViewController

#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNote:(Note *)aNote
{
    if (self = [super init]) {
        self.note = aNote;
    }
    return self;
}

#pragma mark - View's life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.note ? @"Update" : @"New";
    self.titleTextField.text = self.note.title;
    self.contentTextView.text = self.note.content;
    self.authorTextField.text = self.note.author;
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnClicked)];
    self.navigationItem.rightBarButtonItem = doneBtn;
}

#pragma mark - Controls' events

- (void)doneBtnClicked
{
    
    NSString *alertMSG = @"";
    if ([_titleTextField.text length] == 0) {
        alertMSG = @"Title field can not be empty.";
    } else if ([_contentTextView.text length] == 0) {
        alertMSG = @"Content field can not be empty.";
    } else if ([_authorTextField.text length] == 0) {
        alertMSG = @"Author field can not be empty.";
    } else {
        alertMSG = @"";
    }
    
    if (![alertMSG isEqualToString:@""]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:alertMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [av show];
        return;
    }
    
    if (_delegate &&[_delegate respondsToSelector:@selector(noteViewController:didDoneWithNote:update:)]) {
        
        Note *note = self.note ? self.note : [[Note alloc] init];
        note.title = _titleTextField.text;
        note.content = _contentTextView.text;
        note.author = _authorTextField.text;

        BOOL update = self.note ? YES : NO;
        [_delegate noteViewController:self didDoneWithNote:note update:update];
    }
}


- (void)viewDidUnload {
    [self setTitleTextField:nil];
    [self setAuthorTextField:nil];
    [self setContentTextView:nil];
    [super viewDidUnload];
}
@end
