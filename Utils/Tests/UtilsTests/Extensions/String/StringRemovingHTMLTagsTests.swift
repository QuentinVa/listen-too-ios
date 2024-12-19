//
//  StringRemovingHTMLTagsTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringRemovingHTMLTagsTests {

    @Test
    func testRemovingHTMLTags() {
        let string = "<h1>Bonjour cher client!</h1><p>Une personne a été détectée près de votre habitation.</p>"
        #expect(string.removingHTMLTags() == "Bonjour cher client!Une personne a été détectée près de votre habitation.")
    }
}
