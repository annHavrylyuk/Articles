//
//  ATLArticleDetailsViewController.m
//  Articles
//
//  Created by Admin on 12.03.15.
//  Copyright (c) 2015 Anna Havrylyuk. All rights reserved.
//

#import "ATLArticleDetailsViewController.h"
#import "ATLDatabaseManager.h"
#import "ATLArticle.h"
#import "ATLArticleCategory.h"
#import "ATLArticleTableViewCell.h"

@interface ATLArticleDetailsViewController ()

@property (strong, nonatomic) ATLDatabaseManager *articlesManager;
@property (strong, nonatomic) NSArray *articles;
@property (nonatomic) NSInteger userPosition;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleDateAndAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *subcategoryName;
@property (weak, nonatomic) IBOutlet UITextView *articleSubtitle;
@property (weak, nonatomic) IBOutlet UIWebView *articleContent;

@end

@implementation ATLArticleDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.articlesManager = [ATLDatabaseManager sharedManager];
    self.articles = self.articlesManager.selectedSubcategory.articles.allObjects;
    self.userPosition = [self.articles indexOfObject:self.articlesManager.selectedArticle];
    self.subcategoryName.text = self.articlesManager.selectedSubcategory.name;
    [self displaySelectedArticle];
}

- (void) displaySelectedArticle
{
    self.articleTitle.text = self.articlesManager.selectedArticle.title;
    NSDateFormatter *formatterOfDate = [[NSDateFormatter alloc] init];
    formatterOfDate.dateFormat = @"dd.MM.yyyy";
    NSString *date = [formatterOfDate stringFromDate:self.articlesManager.selectedArticle.date];
    NSMutableString *text = [NSMutableString stringWithString:date];
    if(self.articlesManager.selectedArticle.author)
    {
        [text appendFormat:@" %@", self.articlesManager.selectedArticle.author];
    }
    self.articleDateAndAuthor.text = text;
    self.articleImage.image = [UIImage imageWithData:self.articlesManager.selectedArticle.image];
    self.articleSubtitle.text = self.articlesManager.selectedArticle.subtitle;
    [self.articleContent loadHTMLString:self.articlesManager.selectedArticle.content baseURL:nil];

}

- (IBAction)goToNextArticle:(UISwipeGestureRecognizer *)sender
{
    if (self.userPosition < self.articles.count-1)
    {
        ++self.userPosition;
        self.articlesManager.selectedArticle = [self.articles objectAtIndex:self.userPosition];
        [self displaySelectedArticle];
    }
}

- (IBAction)goToPreviousArticle:(UISwipeGestureRecognizer *)sender
{
    if (self.userPosition > 0)
    {
        --self.userPosition;
        self.articlesManager.selectedArticle = [self.articles objectAtIndex:self.userPosition];
        [self displaySelectedArticle];
    }
}

@end
