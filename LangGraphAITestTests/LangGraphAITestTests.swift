import XCTest
@testable import LangGraphAITest

class MockLangGraphService: LangGraphServiceProtocol {
    var result: Result<ChatResponse, Error> = .success(ChatResponse(response: "Default success"))

    func API_Post_langgraph(chatRequest: ChatRequest) async throws -> ChatResponse {
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}

class LangGraphAITestTests: XCTestCase {

    var viewModel: ChatViewModel!
    var mockService: MockLangGraphService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockLangGraphService()
        viewModel = ChatViewModel(chatLLM: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        try super.tearDownWithError()
    }

    func testAskLLM_Success() async {
        // Given
        let expectedResponse = "Hello, this is a test response."
        mockService.result = .success(ChatResponse(response: expectedResponse))
        let question = "Hi"

        // When
        await viewModel.askLLM(question: question)

        // Then
        XCTAssertEqual(viewModel.displayChatResponse, expectedResponse)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testAskLLM_Failure() async {
        // Given
        let expectedError = APIError.serverError(500)
        mockService.result = .failure(expectedError)
        let question = "Hi"

        // When
        await viewModel.askLLM(question: question)

        // Then
        XCTAssertEqual(viewModel.displayChatResponse, "")
        XCTAssertEqual(viewModel.errorMessage, "Error: \(expectedError.localizedDescription)")
    }
}
