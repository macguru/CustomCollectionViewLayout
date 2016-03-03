//
//  MyPersonLayout.m
//  CollectionView
//
//  Created by Max Seelemann on 01.03.16.
//  Copyright © 2016 Max Seelemann. All rights reserved.
//

#import "MyPersonLayout.h"
#import "MyPersonLayoutAttributes.h"

const CGFloat MyPersonLayoutRowHeight	= 50;
const CGFloat MyPersonLayoutItemSpacing	= 10;
const CGSize MyPersonLayoutItemSize		= (CGSize){150, 40};


@interface MyPersonLayout ()
{
	NSArray<MyPersonLayoutAttributes *> *_attributes;
}
@end

@implementation MyPersonLayout

+ (Class)layoutAttributesClass
{
	return MyPersonLayoutAttributes.class;
}

- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context
{
	[super invalidateLayoutWithContext: context];
	
	if (context.invalidateEverything || context.invalidateDataSourceCounts) {
		_attributes = nil;
	}
	// Reset compact use consideration
	if (!CGSizeEqualToSize(context.contentSizeAdjustment, CGSizeZero)) {
		for (MyPersonLayoutAttributes *attrs in _attributes)
			attrs.useShortName = NO;
	}
}

- (void)prepareLayout
{
	[super prepareLayout];
	
	NSMutableArray<MyPersonLayoutAttributes *> *attributes = [NSMutableArray new];
	NSUInteger row = 0;
	CGFloat offset = 0;
	
	CGSize boundsSize = self.collectionView.bounds.size;
	
	NSUInteger itemCount = [self.collectionView numberOfItemsInSection: 0];
	
	for (NSUInteger item=0; item < itemCount; item++) {
		MyPersonLayoutAttributes *oldAttrs = (_attributes.count > item ? _attributes[item] : nil);
		
		CGRect frame;
		frame.size = oldAttrs ? oldAttrs.size : MyPersonLayoutItemSize;
		frame.origin.y = row * MyPersonLayoutRowHeight;
		frame.origin.x = offset;
		
		if (CGRectGetMaxX(frame) > boundsSize.width) {
			row++;
			offset = 0;
			
			frame.origin.y = row * MyPersonLayoutRowHeight;
			frame.origin.x = offset;
		}
		
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
		MyPersonLayoutAttributes *attrs = [MyPersonLayoutAttributes layoutAttributesForCellWithIndexPath: indexPath];
		attrs.frame = frame;
		attrs.useShortName = oldAttrs ? oldAttrs.useShortName : NO;
		[attributes addObject: attrs];
		
		// Advance
		offset += frame.size.width + MyPersonLayoutItemSpacing;
	}
	
	// Check if we're overflowing on second run
	if (_attributes && CGRectGetMaxY(attributes.lastObject.frame) > boundsSize.height) {
		for (MyPersonLayoutAttributes *attrs in attributes)
			attrs.useShortName = YES;
	}
	
	_attributes = attributes;
}

- (CGSize)collectionViewContentSize
{
	CGSize size = CGSizeZero;
	for (MyPersonLayoutAttributes *attrs in _attributes) {
		size.width = MAX(size.width, CGRectGetMaxX(attrs.frame));
		size.height = MAX(size.height, CGRectGetMaxY(attrs.frame));
	}
	return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
	return (self.collectionView.bounds.size.width != newBounds.size.width);
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds
{
	UICollectionViewLayoutInvalidationContext *context = [UICollectionViewLayoutInvalidationContext new];
	context.contentSizeAdjustment = newBounds.size;
	return context;
}

- (nullable NSArray<__kindof MyPersonLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
	return _attributes;
}

- (nullable MyPersonLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return _attributes[indexPath.item];
}

- (BOOL)shouldInvalidateLayoutForPreferredLayoutAttributes:(MyPersonLayoutAttributes *)preferredAttributes withOriginalAttributes:(MyPersonLayoutAttributes *)originalAttributes
{
	if (!CGSizeEqualToSize(preferredAttributes.size, originalAttributes.size)) {
		NSUInteger item = preferredAttributes.indexPath.item;
		_attributes[item].size = preferredAttributes.size;
		return YES;
	}
	
	return NO;
}

@end
