//
//  CardEntity+CoreDataProperties.h
//  Virtual Card
//
//  Created by Peter Gosling on 3/25/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CardEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSString *jobTitle;

@end

NS_ASSUME_NONNULL_END
