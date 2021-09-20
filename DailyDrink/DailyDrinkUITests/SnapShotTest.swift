//
//  SnapShotTest.swift
//  DailyDrinkUITests
//
//  Created by Никита Чирухин on 20.09.2021.
//

import SnapshotTesting
import XCTest
@testable import DailyDrink

class MainViewControllerTests: XCTestCase {
    
  func test_FavoriteController() {
    
    let vc = FavoriteViewController()

    assertSnapshot(matching: vc, as: .image(on: .iPhoneSe))
  }
}
