//
//  AyusoConMortyUITests.swift
//  AyusoConMortyUITests
//
//  Created by Alberto Ayuso Boza on 4/4/25.
//

import XCTest
final class AyusoConMortyUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    /// Does a character search and open a sheet
    ///
    /// This test is responsible for verifying if the application is able to search for a character,
    /// see that they appear on the screen and then enter the character sheet to see more details about it.
    ///
    func testSearchAndOpenCharacter() throws {
        let app = XCUIApplication()
        app.launch()

        let searchTextField = app.textFields["textfieldSearch"]
        XCTAssertTrue(searchTextField.waitForExistence(timeout: 5), "The TextfieldSearch was not found")

        searchTextField.tap()
        searchTextField.typeText("Morty Smith")
        app.keyboards.buttons["Return"].tap()

        let firstCard = app.images["CardImage_2"]
        XCTAssertTrue(firstCard.waitForExistence(timeout: 5), "The CardImage was not found")


        firstCard.tap()

        let detailSheet = app.otherElements["characterSheet"]
        XCTAssertTrue(detailSheet.waitForExistence(timeout: 5), "The characterSheet was not found")
    }
}
