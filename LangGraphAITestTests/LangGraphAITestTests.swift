import XCTest
@testable import LangGraphAITest

class MockLangGraphService: LangGraphServiceProtocol {
    var result: Result<ChatResponse, Error> = .success(ChatResponse(response: "Default success", session_id: "123"))
    var startNewConversationCalled = false

    func API_Post_langgraph(chatRequest: ChatRequest) async throws -> ChatResponse {
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }

    func startNewConversation() {
        startNewConversationCalled = true
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
        mockService.result = .success(ChatResponse(response: expectedResponse, session_id: "123"))
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

    func testStartNewConversation() async {
        // Given
        viewModel.displayChatResponse = "Some previous response"

        // When
        viewModel.startNewConversation()

        // Then
        XCTAssertTrue(mockService.startNewConversationCalled)
        XCTAssertEqual(viewModel.displayChatResponse, "")
        XCTAssertNil(viewModel.errorMessage)
    }
}
