//
//  MyPersonLayoutAttributes.m
//  CollectionView
//
//  Created by Max Seelemann on 01.03.16.
//  Copyright © 2016 Max Seelemann. All rights reserved.
//

#import "MyPersonLayoutAttributes.h"


@implementation MyPersonLayoutAttributes

- (id)init
{
	self = [super init];
	
	if (self) {
		self.useShortName = NO;
	}
	
	return self;
}

- (id)copy
{
	MyPersonLayoutAttributes *attrs = [super copy];
	attrs.useShortName = self.useShortName;
	return attrs;
}

@end
