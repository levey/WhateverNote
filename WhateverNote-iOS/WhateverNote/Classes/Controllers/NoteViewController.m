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
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnClicked)];
    self.navigationItem.rightBarButtonItem = doneBtn;
}

#pragma mark - Controls' events

- (void)doneBtnClicked
{
    if (_delegate &&[_delegate respondsToSelector:@selector(noteViewController:didDoneWithNote:update:)]) {
        Note *note = nil;
        BOOL update = YES;
        if (!self.note) {
            update = NO;
            note = [[Note alloc] init];
            note.title = _titleTextField.text;
            note.content = _contentTextView.text;
            note.author = _authorTextField.text;
        } else {
            note = self.note;
        }
        
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
