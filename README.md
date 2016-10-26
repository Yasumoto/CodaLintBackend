# CodaLintBackend

This is a library which makes setting up a new linter much easier for Coda.

Subclass the `LinterPlugin` class and set these properties:

* `name` // `NSString` with name of the plugin
* `supportedModeIdentifiers` // `NSArray` with the SEEMode name(s) - I kind of guess and check until it works
* `linterPath` // `NSString` with the full path to the binary (someday we can add autodetection)
* `linterArguments` // `NSArray` with any arguments to pass to the linter

You will also need to implement the`parseLintErrors` method of the `LintParser` interface. It will get a string containing the raw output, then you will need to return an array containing  a hash of values of the form:

    NSDictionary *lintedError = @{kValidatorMessageStringKey:errorCodeNumber,
                              kValidatorExplanationStringKey:humanReadableNote,
                                         kValidatorColumnKey:column,
                                           kValidatorLineKey:lineNumber,
                                      kValidatorErrorTypeKey:kValidatorTypeError}; // or kValidatorTypeWarning
