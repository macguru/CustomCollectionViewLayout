//
//  MyPersonCell.m
//  CollectionView
//
//  Created by Max Seelemann on 01.03.16.
//  Copyright © 2016 Max Seelemann. All rights reserved.
//

#import "MyPersonCell.h"
#import "MyPersonLayoutAttributes.h"

@interface MyPersonCell ()

@property(nonatomic, weak) IBOutlet UILabel *nameLabel;

@end

@implementation MyPersonCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder: aDecoder];
	
	if (self) {
		self.layer.cornerRadius = 5;
	}
	
	return self;
}

- (void)setPerson:(MyPerson *)person
{
	if (_person == person)
		return;
	
	_person = person;
	
	self.nameLabel.text = self.person.fullName;
}

- (void)applyLayoutAttributes:(MyPersonLayoutAttributes *)layoutAttributes
{
	[UIView performWithoutAnimation:^{
		[super applyLayoutAttributes: layoutAttributes];
	}];
	
	if (layoutAttributes.useShortName)
		self.nameLabel.text = self.person.shortName;
	else
		self.nameLabel.text = self.person.fullName;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
	layoutAttributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
	
	CGSize fittingSize = [self.contentView systemLayoutSizeFittingSize: CGSizeMake(1000, 100)];
	fittingSize.height = layoutAttributes.size.height;
	layoutAttributes.size = fittingSize;
	
	return layoutAttributes;
}

@end
