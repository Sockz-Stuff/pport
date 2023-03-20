//
//  pportTestCases.swift
//  pportTests
//
//  Created by Daniel Boules on 3/19/23.
//
//
import XCTest
@testable import pport
import Firebase
import FirebaseAuth
import SwiftUI

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
        let auth = Auth.auth()
        let user = try? auth.signOut()
        logoutView.signOut()
        XCTAssertNil(user)
        XCTAssertFalse(auth.currentUser?.isEmailVerified ?? true)
    }
    
    func testNavigateToLogin() {
        logoutView.signOut()
        logoutView.navigateToLogin()
        XCTAssertNil(Auth.auth().currentUser)
    }

}

class RTabViewTests: XCTestCase {
    
    func testTabItemsExist() throws {
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
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        let tabItems = try XCTUnwrap(tabView.tabItems())
        XCTAssertEqual(tabItems[3].image, Image(systemName: "engine.combustion"))
        XCTAssertEqual(tabItems[3].text, "Generator")
    }
    
    func testTabItemAccount() throws {
        let addInfo = UserAddition()
        let tabView = RTabView(addInfo: addInfo)
        
        let tabItems = try XCTUnwrap(tabView.tabItems())
        
        XCTAssertEqual(tabItems[4].image, Image(systemName: "brain.head.profile"))
        XCTAssertEqual(tabItems[4].text, "Account")
    }
}
class PantryIngredientViewTests: XCTestCase {
    func testDeleteButton() throws {
        let ingredient = testI1
        let viewModel = AppViewModel()
        let addInfo = UserAddition()
        viewModel.signedIn = true
        addInfo.fetchData()
        let view = PantryIngredientView(specificType: ingredient).environmentObject(viewModel).environmentObject(addInfo)
        view.setup()
        XCTAssertTrue(view.showingAlert)
        XCTAssertNil(addInfo.pantryIngredients.first(where: { $0.id == ingredient.id }))
    }
}
class IngredientTitleViewTests: XCTestCase {
    func testIngredientTitleView() throws {
        let ingredientTitleView = IngredientTitleView(title: "Test", isDisplayingOrder: true)
        XCTAssertNotNil(ingredientTitleView)
    }
}
class PantryDetailViewTests: XCTestCase {
    var sut: PantryDetailView!
    var currentIngrType: IngredientType!
    override func setUp() {
        super.setUp()
        currentIngrType = IngredientType(id: 1, type: "Vegetable", drawer: [
            Ingredient(id: "1", name: "Carrot", amount: "2", type: "Vegetable", unit: "oz"),
            Ingredient(id: "2", name: "Broccoli", amount: "1", type: "Vegetable", unit: "lb")
        ])
        sut = PantryDetailView(currentIngrType: currentIngrType.ingr_Drawer)
    }
    override func tearDown() {
        sut = nil
        currentIngrType = nil
        super.tearDown()
    }
    
    func testPantryDetailView_Title() throws {
        let title = try XCTUnwrap(sut.navigationTitle)
        XCTAssertEqual(title, currentIngrType.thisType)
    }
    func testPantryDetailView_ListCount() throws {
        let listCount = try XCTUnwrap(sut.currentIngrType).count
        XCTAssertEqual(listCount, currentIngrType.drawer.count)
    }
    func testPantryDetailView_ListItems() throws {
        let item1 = try XCTUnwrap(sut.currentIngrType.first)
        let item2 = try XCTUnwrap(sut.currentIngrType.last)
        XCTAssertEqual(item1.name, "Carrot")
        XCTAssertEqual(item2.name, "Broccoli")
    }
}
class PantryListViewTests: XCTestCase {
    var pantryListView: PantryListView!
    override func setUpWithError() throws {
        pantryListView = PantryListView().environmentObject(UserAddition())
    }
    override func tearDownWithError() throws {
        pantryListView = nil
    }
    func testPantryListView_Title() throws {
        XCTAssertEqual(pantryListView.title, "My Pantry")
    }
    func testPantryListView_NavigationLinks() throws {
        let linksCount = pantryListView.body.children.count(where: { child in
            if case NavigationLink(_, destination: let view) = child {
                return view is PantryDetailView
            }
            return false
        })
        XCTAssertEqual(linksCount, 6)
    }
}
class DatabaseViewModelTests: XCTestCase {
    var databaseViewModel: DatabaseViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        FirebaseApp.configure()
        databaseViewModel = DatabaseViewModel()
    }
    func testGetRecipes() {
        let expectation = self.expectation(description: "Recipes fetched successfully")
        databaseViewModel.getRecipes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertGreaterThan(self.databaseViewModel.Recipes.count, 0, "Recipes should be fetched and stored in the Recipes array")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
class PantryRowViewTests: XCTestCase {
    func test_PantryRowView_title() throws {
        let sut = PantryRowView(title: "Test Title")
        let titleText = try sut.inspect().hStack().text(1).string()
        XCTAssertEqual(titleText, "Test Title")
    }
    func test_PantryRowView_image() throws {
        let sut = PantryRowView(title: "Test Title")
        let image = try sut.inspect().hStack().image(0)
        XCTAssertEqual(image, Image(systemName: "homekit"))
    }
}
class IngredientModelTests: XCTestCase {
    var ingredientModel: IngredientModel!
    override func setUp() {
        super.setUp()
        ingredientModel = IngredientModel()
    }
    override func tearDown() {
        ingredientModel = nil
        super.tearDown()
    }
    func testAddIngredient() {
        let initialCount = ingredientModel.ingredients.count
        let testIngredient = Ingredient(id: "1", name: "Test Ingredient", amount: "1", type: "Test Type", unit: "Test Unit")
        ingredientModel.addIngredient(testIngredient)
        XCTAssertEqual(ingredientModel.ingredients.count, initialCount + 1)
        XCTAssertTrue(ingredientModel.ingredients.contains(testIngredient))
    }
}
class PantryModelTests: XCTestCase {
    var pantryModel: TestPantryModel!
    override func setUp() {
        super.setUp()
        pantryModel = TestPantryModel()
    }
    override func tearDown() {
        pantryModel = nil
        super.tearDown()
    }
    func testAddPantry() {
        let initialCount = pantryModel.pantries.count
        let testPantry = Pantry(id: 1, shelf: [])
        pantryModel.addPantry(testPantry)
        XCTAssertEqual(pantryModel.pantries.count, initialCount + 1)
        XCTAssertTrue(pantryModel.pantries.contains(testPantry))
    }
}
class IngredientTypeTests: XCTestCase {
    func testIngredientTypeInit() {
        let ingredientType = IngredientType(id: 1, type: "Meat", drawer: [])
        XCTAssertEqual(ingredientType.id, 1)
        XCTAssertEqual(ingredientType.type, "Meat")
        XCTAssertTrue(ingredientType.drawer.isEmpty)
    }
    func testIngredientTypeDrawer() {
        let ingredientType = IngredientType(id: 1, type: "Meat", drawer: [])
        let ingredient = Ingredient(id: "5", name: "Beef", amount: "1", type: "Meat", unit: "LB")
        ingredientType.drawer.append(ingredient)
        XCTAssertTrue(ingredientType.drawer.contains(ingredient))
    }
}
class RecipeModelTests: XCTestCase {
    func testRecipeModel() throws {
        let recipe = Recipe(id: "1", Name: "Pasta", Ingredients: ["noodles", "sauce", "meat"], Quantity: [1, 1, 1], Link: "https://www.example.com")
        let recipeModel = RecipeModel(recipe: recipe)
        XCTAssertEqual(recipeModel.id, "1")
        XCTAssertEqual(recipeModel.name, "Pasta")
        XCTAssertEqual(recipeModel.ingredients, ["noodles", "sauce", "meat"])
        XCTAssertEqual(recipeModel.quantity, [1, 1, 1])
        XCTAssertEqual(recipeModel.link, "https://www.example.com")
    }
}
