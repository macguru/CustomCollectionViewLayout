//
//  ViewController.m
//  CollectionView
//
//  Created by Max Seelemann on 01.03.16.
//  Copyright © 2016 Max Seelemann. All rights reserved.
//

#import "ViewController.h"
#import "MyPerson.h"
#import "MyPersonCell.h"


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic) NSArray<MyPerson *> *persons;

@property(nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSMutableArray *newPersons = [NSMutableArray new];
	for (NSUInteger i=0; i<20; i++)
		[newPersons addObject: [MyPerson new]];
	self.persons = newPersons;
}

- (IBAction)remove:(id)sender
{
	self.persons = [self.persons subarrayWithRange: NSMakeRange(0, self.persons.count-1)];
	[self.collectionView reloadData];
}

- (IBAction)add:(id)sender
{
	self.persons = [self.persons arrayByAddingObject: [MyPerson new]];
	[self.collectionView reloadData];
}


#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.persons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MyPersonCell *cell = (MyPersonCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"person" forIndexPath:indexPath];
	cell.person = self.persons[indexPath.item];
	
	return cell;
}

@end
