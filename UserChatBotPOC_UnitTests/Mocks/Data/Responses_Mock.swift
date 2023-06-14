//
//  Responses_Mock.swift
//  UserChatBotPOC_UnitTests
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import Foundation
@testable import UserChatBotPOC



let apiErrorMock: RESTServiceError = RESTServiceError.responseError;

let validResponseMock: Result<[User], Error> = .success(MockUsersDataList)

let apiErrorResponseMock: Result<[User], Error> = .failure(apiErrorMock)
