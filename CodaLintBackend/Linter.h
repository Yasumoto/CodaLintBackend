//
//  Linter.h
//  CodaPylint
//
//  Created by Joseph Mehdi Smith on 5/11/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodaPluginsController.h"
#import "Runner.h"
#import "LintParser.h"

@interface Linter : NSObject <CodaValidator, RunnerDelegate>

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id<LintParser> parser;
@property (nonatomic, strong) NSString *linterPath;
@property (nonatomic, strong) NSArray *linterArguments;
@property (nonatomic, strong) NSString *linterCwd; // This is used to set which directory to run the linter

@end
