import XCTest

import echoserverTests

var tests = [XCTestCaseEntry]()
tests += echoserverTests.allTests()
XCTMain(tests)
