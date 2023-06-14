//
//  RESTService_Test.swift
//  UserChatBotPOC_UnitTests
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import XCTest
import Combine
@testable import UserChatBotPOC

final class RESTService_Test: XCTestCase {
    
    // Variables
    var cancelables = Set<AnyCancellable>()
    let restService = MockRESTService()
    let validURL = "https://valid.url.com/hehe"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MockRESTService_getRequest_returnFailurePromiseForInvalidURL() {
        // Given
        let invalidURL = "this is not a url"
        let expectation = XCTestExpectation(description: "Request should fail due to bad url")
        
        // When
        restService.getRequest(urlString: invalidURL, type: User.self)
            // Then
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNotNil(error)
                    XCTAssertEqual(error as? RESTServiceError, RESTServiceError.invalidURL)
                } else {
                    // force error
                    XCTFail("Request should have failed due to invalid URL")
                }
                // indicates it has check the conditional
                expectation.fulfill()
            }, receiveValue: { value in
                // indicates it reached recieveValue in case test is failing
                XCTFail("Request should have failed due to invalid URL")
                expectation.fulfill()
            })
            .store(in: &cancelables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_MockRESTService_getRequest_returnSuccessePromiseForValidURL() {
        // Given
        let expectation = XCTestExpectation(description: "Request should pass due to valid url")
        
        // When
        restService.getRequest(urlString: validURL, type: User.self)
            // Then
            .sink(receiveCompletion: { completion in
                switch completion  {
                case .failure(_):
                    XCTFail("completion entered failute ~ Request should have successed due to valid URL")
                case .finished:
                    // entered finished case
                    XCTAssertTrue(true)
                }
                // indicates it has check the conditional
                expectation.fulfill()
            }, receiveValue: { value in
                    // success value will be []
                XCTAssertTrue(value.isEmpty)
                expectation.fulfill()
            })
            .store(in: &cancelables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_MockRESTService_getRequest_subscriber_returnFailurePromiseForDecodingError() {
        // Given
        let decodingErrorMock: DecodingError = DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Mock decoding error"))
        let decodingErrorResponseMock: Result<[User], Error> = .failure(decodingErrorMock)
        let decodingErrorFutureMock = Future<[User], Error> { promise in
            promise(decodingErrorResponseMock)
        }
        let expectation = XCTestExpectation(description: "Request should fail due to decoding error")
        
        // When
        Just(decodingErrorFutureMock)
            // Then
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    switch error {
                    case let decodingError as? DecodingError:
                        print(decodingError)
                        XCTAssertEqual(decodingError.localizedDescription, decodingErrorMock.localizedDescription)
                    default:
                        XCTFail("Failed Completion Error Switch: Should have entered decoding error case")
                    }
                }
                expectation.fulfill()
            }, receiveValue: { value in
                print(value)
                XCTFail("Failed Completion Error Switch: Should have entered decoding error case")
                expectation.fulfill()
            })
            .store(in: &cancelables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    

}
