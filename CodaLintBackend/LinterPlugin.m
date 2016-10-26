//
//  ShellCheckPlugin.m
//  CodaShellCheck
//
//  Created by Joe Smith on 5/6/16.
//  Copyright © 2016 Joe Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinterPlugin.h"
#import "Linter.h"

@interface LinterPlugin()

@property (nonatomic, strong) CodaPlugInsController* controller;

@end

@implementation LinterPlugin

@synthesize linterPath = _linterPath;
@synthesize linterArguments = _linterArguments;

- (id)initWithPlugInController:(CodaPlugInsController*)aController plugInBundle:(NSObject <CodaPlugInBundle> *)plugInBundle
{
    if ( (self = [super init]) != nil )
    {
        self.controller = aController;
    }

    return self;
}

- (NSString *) name {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSArray*)supportedModeIdentifiers {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSString *) temporaryFileWithContents:(NSString *)contents {
    // Props to http://www.cocoawithlove.com/2009/07/temporary-files-and-folders-in-cocoa.html
    NSString *tempFileTemplate = [NSTemporaryDirectory() stringByAppendingPathComponent:@"codalintbackend.XXXXXX"];
    const char *tempFileTemplateCString = [tempFileTemplate fileSystemRepresentation];
    char *tempFileNameCString = (char *)malloc(strlen(tempFileTemplateCString) + 1);
    strcpy(tempFileNameCString, tempFileTemplateCString);
    int fileDescriptor = mkstemp(tempFileNameCString);

    if (fileDescriptor == -1)
    {
        // handle file creation failure eventually
    }

    // This is the file name if you need to access the file by name, otherwise you can remove
    // this line.
    NSString *tempFileName =
    [[NSFileManager defaultManager]
     stringWithFileSystemRepresentation:tempFileNameCString
     length:strlen(tempFileNameCString)];

    free(tempFileNameCString);

    NSFileHandle *tempFileHandle =
    [[NSFileHandle alloc]
     initWithFileDescriptor:fileDescriptor
     closeOnDealloc:NO];

    [tempFileHandle writeData:[contents dataUsingEncoding:NSUTF8StringEncoding]];

    return tempFileName;
}

- (id<CodaValidator>)validatorForModeIdentifier:(NSString*)modeIdentifier text:(NSString*)text encoding:(NSStringEncoding)encoding delegate:(id<CodaValidatorDelegate>)aDelegate {

    Linter *validator = [[Linter alloc] init];
    validator.name = self.name;
    validator.linterCwd = self.controller.siteLocalPath;
    validator.linterPath = self.linterPath;
    validator.linterArguments = self.linterArguments;
    validator.delegate = aDelegate;
    
    validator.filePath = [self temporaryFileWithContents:text];
    return validator;
}

@end
