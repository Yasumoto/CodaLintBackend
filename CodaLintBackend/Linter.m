//
//  Linter.m
//  CodaShellCheck
//
//  Created by Joseph Mehdi Smith on 5/11/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#import "Linter.h"

@interface Linter()

@property (nonatomic, strong) Runner* runner;
@property (nonatomic, strong) id<CodaValidatorDelegate> validatorDelegate;

@end

@implementation Linter

@synthesize runner = _runner;
@synthesize filePath = _filePath;
@synthesize validatorDelegate = _validatorDelegate;
@synthesize name = _name;
@synthesize linterPath = _linterPath;
@synthesize parser = _parser;
@synthesize linterArguments = _linterArguments;
@synthesize linterCwd = _linterCwd;

NSString *errorDomain = @"com.bjoli.CodaLintBackend.ErrorDomainLinter";

/**
 Starts validation.

 This is the primary validation method, it will be called on a secondary thread.
 */

- (void)validate {
    self.runner = [[Runner alloc] init];
    self.runner.delegate = self;
    [self.runner executeBinary:self.linterPath atPath:self.linterCwd withArguments:[self.linterArguments arrayByAddingObject:self.filePath]];
}


/**
 Cancels validation.

 The validator should end validation and do whatever clean-up is necessary.
 */

- (void)cancel {
    [self.runner cancel];
}


/**
 Returns a human-readable name of the syntax being validated.
 */

- (NSString*)name {
    return @"CodaLintBackend";
}


/**
 Sets the validator delegate.
 @param delegate Opaque object which conforms to the CodaValidatorDelegate protocol, may be nil.
 */

- (void)setDelegate:(id<CodaValidatorDelegate>)delegate {
    self.validatorDelegate = delegate;
}


/**
 Return the validator delegate object.
 */

- (id<CodaValidatorDelegate>)delegate {
    return self.validatorDelegate;

}


// Runner Delegate
- (void) executionComplete:(NSString *)output withError:(NSString *)errorMessage {

    NSError *error = nil;
    if (errorMessage.length > 0) {
        NSString *desc = NSLocalizedString(errorMessage, @"");
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        error = [NSError errorWithDomain:errorDomain
                                    code:-101
                                userInfo:userInfo];
    }


    [self.delegate validator:self didComplete:[self.parser parseLintErrors:output] error:nil];
}

@end
