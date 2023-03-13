//
//  pportTests.swift
//  pportTests
//
//  Created by Marshall Jones on 3/9/23.
//
//  I used "LoginView instead of Dlogin but it shouldn't matter.

import XCTest
@testable import pport
import Firebase
import FirebaseAuth

class LoginViewTests: XCTestCase {
    func testLoginButtonEnabled() {
        let loginView = LoginView()
        loginView.email = "test@example.com"
        loginView.password = "password"
        
        let button = loginView.body.subviews[0].subviews[3] as! Button<Text>
        XCTAssertTrue(button.isEnabled)
    }
    
    func testCreateAccountButton() {
        let loginView = LoginView()
        loginView.email = "test@example.com"
        loginView.password = "password"
        
        let button = loginView.body.subviews[0].subviews[4] as! Button<Text>
    
        button.simulateTap()
        
        XCTAssertTrue(loginView.showCreateAccountForm)
    }
    func testLoginButtonEnabled() {
        let loginView = LoginView()
        loginView.email = "test@example.com"
        loginView.password = "password"
        
        let button = loginView.body.subviews[0].subviews[3] as! Button<Text>
        XCTAssertTrue(button.isEnabled)
    }
    
    func testCreateAccountButton() {
        let loginView = LoginView()
        loginView.email = "test@example.com"
        loginView.password = "password"
        
        let button = loginView.body.subviews[0].subviews[4] as! Button<Text>
        
        button.simulateTap()
        
        XCTAssertTrue(loginView.showCreateAccountForm)
    }
    func testLoginButtonDisabledWhenFieldsEmpty() {
        let loginView = LoginView()
        loginView.email = ""
        loginView.password = ""

        let button = loginView.body.subviews[0].subviews[3] as! Button<Text>
        XCTAssertFalse(button.isEnabled)
    }

    func testCreateAccountButtonNavigatesToCreateAccountForm() {
        let loginView = LoginView()
        loginView.createAccountEmail = "test@example.com"
        loginView.createAccountPassword = "password"
        loginView.showCreateAccountForm = false
        loginView.body.subviews[0].subviews[4].tap()

        XCTAssertTrue(loginView.showCreateAccountForm)
    }

    func testCreateAccountButtonDisabledWhenFieldsEmpty() {
        let loginView = LoginView()
        loginView.createAccountEmail = ""
        loginView.createAccountPassword = ""

        let button = loginView.body.subviews[0].subviews[4] as! Button<Text>
        XCTAssertFalse(button.isEnabled)
    }

    func testErrorMessageDisplayedOnIncorrectLogin() {
        let loginView = LoginView()
        loginView.email = "test@example.com"
        loginView.password = "incorrectpassword"

        loginView.body.subviews[0].subviews[3].tap()

        let errorMessage = loginView.body.subviews[0].subviews[5] as! Text
        XCTAssertEqual(errorMessage.text, "Sign in failed: The email address is badly formatted.")
    }

    func testSuccessfulLoginNavigatesToMainScreen() {
        let loginView = LoginView()
        loginView.email = "test@example.com"
        loginView.password = "password"

        loginView.body.subviews[0].subviews[3].tap()

        let window = loginView.window
        XCTAssertTrue(window?.rootViewController is RTabView)
    }

    func testCreateAccountSuccess() {
        let loginView = LoginView()
        loginView.createAccountEmail = "newuser@example.com"
        loginView.createAccountPassword = "newpassword"
        loginView.showCreateAccountForm = false
        loginView.body.subviews[0].subviews[4].tap()

        let window = loginView.window
        XCTAssertTrue(window?.rootViewController is RTabView)
    }

    func testErrorMessageDisplayedOnDuplicateEmail() {
        let loginView = LoginView()
        loginView.createAccountEmail = "test@example.com"
        loginView.createAccountPassword = "password"
        loginView.showCreateAccountForm = false
        loginView.body.subviews[0].subviews[4].tap()

        let errorMessage = loginView.body.subviews[0].subviews[5] as! Text
        XCTAssertEqual(errorMessage.text, "Account creation failed: The email address is already in use by another account.")
    }
}

class LogoutViewTests: XCTestCase {
    
    var logoutView: LogoutView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        logoutView = LogoutView()
    }

    override func tearDownWithError() throws {
        logoutView = nil
        try super.tearDownWithError()
    }
    
    func testSignOut() {
        // Given
        let auth = Auth.auth()
        let user = try? auth.signOut()
        
        // When
        logoutView.signOut()
        
        // Then
        XCTAssertNil(user)
        XCTAssertFalse(auth.currentUser?.isEmailVerified ?? true)
    }
    
    func testNavigateToLogin() {
        // Given
        logoutView.signOut()
        
        // When
        logoutView.navigateToLogin()
        
        // Then
        XCTAssertNil(Auth.auth().currentUser)
    }

}

class RTabViewTests: XCTestCase {
    
    func testTabItemsExist() throws {
        // Given
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems.count, 5)
    }
    
    func testTabItemHome() throws {
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems[0].image, Image(systemName: "house"))
        XCTAssertEqual(tabItems[0].text, "Home")
    }
    
    func testTabItemAdd() throws {
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems[1].image, Image(systemName: "plus"))
        XCTAssertEqual(tabItems[1].text, "Add")
    }
    
    func testTabItemRecipes() throws {
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems[2].image, Image(systemName: "book"))
        XCTAssertEqual(tabItems[2].text, "Recipes")
    }
    
    func testTabItemGenerator() throws {
        // Given
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems[3].image, Image(systemName: "engine.combustion"))
        XCTAssertEqual(tabItems[3].text, "Generator")
    }
    
    func testTabItemAccount() throws {
        // Given
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems[4].image, Image(systemName: "brain.head.profile"))
        XCTAssertEqual(tabItems[4].text, "Account")
    }
}
