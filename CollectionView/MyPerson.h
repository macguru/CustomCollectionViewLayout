//
//  MyPerson.h
//  CollectionView
//
//  Created by Max Seelemann on 01.03.16.
//  Copyright © 2016 Max Seelemann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPerson : NSObject

- (instancetype)init;

@property(nonatomic, readonly) NSString *fullName;
@property(nonatomic, readonly) NSString *shortName;

@end
