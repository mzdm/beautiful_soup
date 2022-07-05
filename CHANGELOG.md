## 0.3.0

- Added new **Modifying the Tree** methods: `newTag()`, `clear()`, `decompose()`, `wrap()`,
`unwrap()`, `setter for .name (tag name)`.
- Added new parameters to `getText()` **Output** method: `separator`, `strip`.
- Added new **Output** method (partial support): `prettify()`.
- Added new helper methods for element's **attributes**: `removeAttr()`, `hasAttr()`, 
`setAttr()`, `getAttrValue()`.
- Added new **Tags**: `b`, `i`.
- Added tests & coverage.
- Updated README.

## 0.2.0

- Renamed parameter `customSelector` to `selector` in **Searching the Tree** methods.
- Added new parameters to **Searching the Tree** methods: `id`, `class_`, `regex`, 
`string` and `limit`.

## 0.1.0

- Added new **Navigating the Tree** methods: `.nextElement`, `.nextElements`, `.previousElement`,
  `.previousElements`, `.nextParsed`, `.nextParsedAll`, `.previousParsed`, `.previousParsedAll`.
- Added new **Searching the Tree** methods: `findParent()`, `findParents()`, `findNextSibling()`,
  `findNextSiblings()`, `findPreviousSibling()`, `findPreviousSiblings()`,
  `findNextElement()`, `findAllNextElements()`, `findPreviousElement()`, `findAllPreviousElements()`,
  `findNextParsed()`, `findNextParsedAll()`, `findPreviousParsed()`, `findPreviousParsedAll()`.
- Added new **Output** method: `.text`.
- Added more tests. 
- Removed unused dependency.
- Updated README.  
- Improved documentation.

## 0.0.1

- Initial version.
