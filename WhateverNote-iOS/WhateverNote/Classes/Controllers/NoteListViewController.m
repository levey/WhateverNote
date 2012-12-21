//
//  NoteListViewController.m
//  WhateverNote
//
//  Created by Levey on 12/21/12.
//  Copyright (c) 2012 SlyFairy. All rights reserved.
//

#import "NoteListViewController.h"
#import "Note.h"
#import "NoteViewController.h"
@interface NoteListViewController ()

@property (nonatomic, strong) AFHTTPClient *httpClient;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *indexPathToBeDeleted;
@end

@implementation NoteListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Note List";
    
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newBtnClicked)];
    self.navigationItem.rightBarButtonItem = newBtn;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/"]];
    [self refreshList];
}

#pragma mark - Private methods

-(void)refreshList
{
//    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/notes"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"List: %@", JSON);
//        NSMutableArray *mArr = [NSMutableArray array];
//        for (NSDictionary *attributes in JSON) {
//            Note *note = [[Note alloc] initWithAttributes:attributes];
//            [mArr addObject:note];
//        }
//        self.dataArray = mArr;
//        [self.tableView reloadData];
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        NSLog(@"Failed to get note list, error >> %@",error);
//    }];
//    [operation start];
    
    [self.httpClient getPath:@"notes" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseArray = [responseObject objectFromJSONData];
        NSLog(@"%@", responseArray);
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *attributes in responseArray) {
            Note *note = [[Note alloc] initWithAttributes:attributes];
            [mArr addObject:note];
        }
        self.dataArray = mArr;
        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to get note list, ERROR >> %@", error);
    }];
}

- (void)deleteNote:(Note *)aNote
{
    NSLog(@"Delete a note with ID >> %@", aNote.noteID);
    [self.httpClient deletePath:[NSString stringWithFormat:@"notes/%@",aNote.noteID]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject objectFromJSONData]);
        NSDictionary *dict = [responseObject objectFromJSONData];
        if ([dict[@"success"] integerValue] == 1) {
            [self.dataArray removeObjectAtIndex:self.indexPathToBeDeleted.row];
            [self.tableView deleteRowsAtIndexPaths:@[self.indexPathToBeDeleted] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to delete a note, ERROR >> %@", error);
    }];
}

- (void)updateNote:(Note *)aNote
{
    
}

- (void)createNote:(Note *)aNote
{
    NSLog(@"%@", aNote.title);
    [self.httpClient postPath:@"notes" parameters:@{@"title" : aNote.title, @"content" : aNote.content, @"author" : aNote.author} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject objectFromJSONData]);
        NSDictionary *dict = [responseObject objectFromJSONData];
        if ([dict[@"success"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
            [self refreshList];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to create a note, ERROR >> %@", error);
    }];
}

#pragma mark - Controls' events

- (void)newBtnClicked
{
    NoteViewController *nvc = [[NoteViewController alloc] init];
    nvc.delegate = (id)self;
    [self.navigationController pushViewController:nvc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.dataArray[indexPath.row] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexPathToBeDeleted = indexPath;
        
        [self deleteNote:self.dataArray[indexPath.row]];
    }   
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - NoteViewController delegate

- (void)noteViewController:(NoteViewController *)viewController didDoneWithNote:(Note *)aNote update:(BOOL)isUpdate
{
    if (!isUpdate) {
        [self createNote:aNote];
    }
}

@end
