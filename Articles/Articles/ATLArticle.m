//
//  ATLArticle.m
//  Articles
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 Anna Havrylyuk. All rights reserved.
//

#import "ATLArticle.h"
#import "ATLAppDelegate.h"
#import "ATLArticleCategory.h"

@implementation ATLArticle

@dynamic identifier;
@dynamic title;
@dynamic author;
@dynamic date;
@dynamic ranking;
@dynamic subtitle;
@dynamic content;
@dynamic image;
@dynamic category;

+ (ATLArticle *)createNewArticle:(NSDictionary *)data OfCategory:(ATLArticleCategory *)category
{
    ATLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    ATLArticle *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"ATLArticle"
                                                           inManagedObjectContext:context];
    newArticle.identifier = [data objectForKey:@"id"];
    newArticle.title = [data objectForKey:@"title"];
    NSTimeInterval timeInterval = [[data objectForKey:@"date"] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy";
    newArticle.date = [formatter stringFromDate:date];
    newArticle.ranking =[data objectForKey:@"ranking"];
    newArticle.subtitle = [data objectForKey:@"subtitle"];
    newArticle.category = category;
    NSError *error;
    [context save:&error];
    [category addArticlesObject:newArticle];
    return newArticle;
}

@end
