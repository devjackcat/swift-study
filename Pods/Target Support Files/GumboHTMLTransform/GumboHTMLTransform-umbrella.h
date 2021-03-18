#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "attribute.h"
#import "char_ref.h"
#import "error.h"
#import "gumbo.h"
#import "insertion_mode.h"
#import "OCGumbo+Query.h"
#import "OCGumbo.h"
#import "parser.h"
#import "string_buffer.h"
#import "string_piece.h"
#import "tag_enum.h"
#import "tag_gperf.h"
#import "tag_sizes.h"
#import "tag_strings.h"
#import "tokenizer.h"
#import "tokenizer_states.h"
#import "token_type.h"
#import "utf8.h"
#import "util.h"
#import "vector.h"

FOUNDATION_EXPORT double GumboHTMLTransformVersionNumber;
FOUNDATION_EXPORT const unsigned char GumboHTMLTransformVersionString[];

