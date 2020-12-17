import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(VectorProtocolTests.allTests),
    ]
}
#endif
