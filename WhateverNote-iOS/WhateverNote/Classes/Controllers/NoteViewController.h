//
//  NoteViewController.h
//  WhateverNote
//
//  Created by Levey on 12/21/12.
//  Copyright (c) 2012 SlyFairy. All rights reserved.
//

#import "Note.h"

@protocol NoteViewControllerDelegate;

@interface NoteViewController : UIViewController

@property (nonatomic, assign) id<NoteViewControllerDelegate> delegate;
@property (nonatomic, strong) Note *note;
- (id)initWithNote:(Note *)aNote;

@end

@protocol NoteViewControllerDelegate <NSObject>

- (void)noteViewController:(NoteViewController *)viewController didDoneWithNote:(Note *)aNote update:(BOOL)isUpdate;

@end