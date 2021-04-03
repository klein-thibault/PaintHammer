import XCTest

import EnvironmentTests

var tests = [XCTestCaseEntry]()
tests += EnvironmentTests.allTests()
XCTMain(tests)
