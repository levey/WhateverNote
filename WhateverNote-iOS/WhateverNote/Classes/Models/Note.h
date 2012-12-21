//
//  Note.h
//  WhateverNote
//
//  Created by Levey on 12/21/12.
//  Copyright (c) 2012 SlyFairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, strong) NSString *noteID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *author;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
