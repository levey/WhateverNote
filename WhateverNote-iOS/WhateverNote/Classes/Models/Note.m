//
//  Note.m
//  WhateverNote
//
//  Created by Levey on 12/21/12.
//  Copyright (c) 2012 SlyFairy. All rights reserved.
//

#import "Note.h"

@implementation Note

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _noteID = [attributes valueForKeyPath:@"_id"];
        _title = [attributes valueForKeyPath:@"title"];
        _content = [attributes valueForKeyPath:@"content"];
        _author = [attributes valueForKeyPath:@"author"];
    }

    return self;
}

@end
