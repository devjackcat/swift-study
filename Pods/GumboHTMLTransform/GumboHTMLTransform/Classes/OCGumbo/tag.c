// Copyright 2011 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Author: jdtang@google.com (Jonathan Tang)

#include "gumbo.h"

#include <assert.h>
#include <ctype.h>
#include <string.h>

const char* kGumboTagNames[] = {
"html",
"head",
"title",
"base",
"link",
"meta",
"style",
"script",
"noscript",
"template",
"body",
"article",
"section",
"nav",
"aside",
"h1",
"h2",
"h3",
"h4",
"h5",
"h6",
"hgroup",
"header",
"footer",
"address",
"p",
"hr",
"pre",
"blockquote",
"ol",
"ul",
"li",
"dl",
"dt",
"dd",
"figure",
"figcaption",
"main",
"div",
"a",
"em",
"strong",
"small",
"s",
"cite",
"q",
"dfn",
"abbr",
"data",
"time",
"code",
"var",
"samp",
"kbd",
"sub",
"sup",
"i",
"b",
"u",
"mark",
"ruby",
"rt",
"rp",
"bdi",
"bdo",
"span",
"br",
"wbr",
"ins",
"del",
"image",
"img",
"iframe",
"embed",
"object",
"param",
"video",
"audio",
"source",
"track",
"canvas",
"map",
"area",
"math",
"mi",
"mo",
"mn",
"ms",
"mtext",
"mglyph",
"malignmark",
"annotation-xml",
"svg",
"foreignobject",
"desc",
"table",
"caption",
"colgroup",
"col",
"tbody",
"thead",
"tfoot",
"tr",
"td",
"th",
"form",
"fieldset",
"legend",
"label",
"input",
"button",
"select",
"datalist",
"optgroup",
"option",
"textarea",
"keygen",
"output",
"progress",
"meter",
"details",
"summary",
"menu",
"menuitem",
"applet",
"acronym",
"bgsound",
"dir",
"frame",
"frameset",
"noframes",
"isindex",
"listing",
"xmp",
"nextid",
"noembed",
"plaintext",
"rb",
"strike",
"basefont",
"big",
"blink",
"center",
"font",
"marquee",
"multicol",
"nobr",
"spacer",
"tt",
"rtc",
    "",  // TAG_UNKNOWN
    "",  // TAG_LAST
};

static const unsigned char kGumboTagSizes[] = {
    4, 4, 5, 4, 4, 4, 5, 6, 8, 8, 4, 7, 7, 3, 5, 2, 2, 2, 2, 2, 2, 6, 6, 6, 7, 1, 2, 3, 10, 2, 2, 2, 2, 2, 2, 6, 10, 4, 3, 1, 2, 6, 5, 1, 4, 1, 3, 4, 4, 4, 4, 3, 4, 3, 3, 3, 1, 1, 1, 4, 4, 2, 2, 3, 3, 4, 2, 3, 3, 3, 5, 3, 6, 5, 6, 5, 5, 5, 6, 5, 6, 3, 4, 4, 2, 2, 2, 2, 5, 6, 10, 14, 3, 13, 4, 5, 7, 8, 3, 5, 5, 5, 2, 2, 2, 4, 8, 6, 5, 5, 6, 6, 8, 8, 6, 8, 6, 6, 8, 5, 7, 7, 4, 8, 6, 7, 7, 3, 5, 8, 8, 7, 7, 3, 6, 7, 9, 2, 6, 8, 3, 5, 6, 4, 7, 8, 4, 6, 2, 3,
    0,  // TAG_UNKNOWN
    0,  // TAG_LAST
};

const char* gumbo_normalized_tagname(GumboTag tag) {
  assert(tag <= GUMBO_TAG_LAST);
  return kGumboTagNames[tag];
}

void gumbo_tag_from_original_text(GumboStringPiece* text) {
  if (text->data == NULL) {
    return;
  }

  assert(text->length >= 2);
  assert(text->data[0] == '<');
  assert(text->data[text->length - 1] == '>');
  if (text->data[1] == '/') {
    // End tag.
    assert(text->length >= 3);
    text->data += 2;  // Move past </
    text->length -= 3;
  } else {
    // Start tag.
    text->data += 1;  // Move past <
    text->length -= 2;
    // strnchr is apparently not a standard C library function, so I loop
    // explicitly looking for whitespace or other illegal tag characters.
    for (const char* c = text->data; c != text->data + text->length; ++c) {
      if (isspace(*c) || *c == '/') {
        text->length = c - text->data;
        break;
      }
    }
  }
}

static int case_memcmp(const char* s1, const char* s2, unsigned int n) {
  while (n--) {
    unsigned char c1 = tolower(*s1++);
    unsigned char c2 = tolower(*s2++);
    if (c1 != c2) return (int) c1 - (int) c2;
  }
  return 0;
}

#include "tag_gperf.h"
#define TAG_MAP_SIZE (sizeof(kGumboTagMap) / sizeof(kGumboTagMap[0]))

GumboTag gumbo_tagn_enum(const char* tagname, unsigned int length) {
  if (length) {
    unsigned int key = tag_hash(tagname, length);
    if (key < TAG_MAP_SIZE) {
      GumboTag tag = kGumboTagMap[key];
      if (length == kGumboTagSizes[(int) tag] &&
          !case_memcmp(tagname, kGumboTagNames[(int) tag], length))
        return tag;
    }
  }
  return GUMBO_TAG_UNKNOWN;
}

GumboTag gumbo_tag_enum(const char* tagname) {
  return gumbo_tagn_enum(tagname, strlen(tagname));
}
