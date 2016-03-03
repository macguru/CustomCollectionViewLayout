//
//  MyPerson.m
//  CollectionView
//
//  Created by Max Seelemann on 01.03.16.
//  Copyright © 2016 Max Seelemann. All rights reserved.
//

#import "MyPerson.h"

@implementation MyPerson

- (instancetype)init
{
	self = [super init];

	if (self) {
		NSString *firstName = self.class.newFirstName;
		NSString *lastName = self.class.newLastName;
		
		
		_fullName = [NSString stringWithFormat: @"%@ %@", firstName, lastName];
		_shortName = [NSString stringWithFormat: @"%@ %@.", firstName, [lastName substringToIndex: 1]];
	}
	
	return self;
}

+ (NSString *)newFirstName
{
	static NSArray *names;
	names = names ?: @[@"Elena", @"Rosalba", @"Kris", @"Antonia", @"Mitchel", @"Laurence", @"Catarina", @"Chun", @"Hoa", @"Salena", @"Cristie", @"Oswaldo", @"Shon", @"Ila", @"Mara", @"Stewart", @"Hope", @"Hipolito", @"Petrina", @"Larae"];
	
	return names[random() % names.count];
}

+ (NSString *)newLastName
{
	static NSArray *names;
	names = names ?: @[@"Lewis", @"Jone", @"Palma", @"Jared", @"Julia", @"Bradford", @"Libbie", @"Shantae", @"Racheal", @"Aleta", @"Raul", @"Michelina", @"Nita", @"Myung", @"Marylin", @"Cynthia", @"Jonah", @"Xavier", @"Deneen", @"Mariko"];
	
	return names[random() % names.count];
}

@end
