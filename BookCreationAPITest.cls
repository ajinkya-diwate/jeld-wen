@isTest
private class BookCreationAPITest {

    // Test method to validate successful book creation
    @isTest
    static void testValidBookCreation() {
        // Prepare valid book data
        List<BookCreationAPI.BookInfo> validBookList = new List<BookCreationAPI.BookInfo>();
        BookCreationAPI.BookInfo validBook = new BookCreationAPI.BookInfo();
        validBook.Id = '123';
        validBook.title = 'Test Book';
        validBook.author = 'Test Author';
        validBook.published_year = '2023';
        validBookList.add(validBook);
        
        // Simulate REST request
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/createBooks';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serialize(validBookList));
        RestContext.request = req;
        
        Test.startTest();
        // Call the REST resource method
        String response = BookCreationAPI.doPost();
        Test.stopTest();
        
        // Verify the expected response
        System.assertEquals('Books created successfully', response);
    }

    // Test method to validate book creation with missing ID
    @isTest
    static void testInvalidBookCreationMissingId() {
        // Prepare invalid book data with missing ID
        List<BookCreationAPI.BookInfo> invalidBookList = new List<BookCreationAPI.BookInfo>();
        BookCreationAPI.BookInfo invalidBook = new BookCreationAPI.BookInfo();
        invalidBook.title = 'Test Book';
        invalidBook.author = 'Test Author';
        invalidBook.published_year = '2023';
        invalidBookList.add(invalidBook);
        
        // Simulate REST request
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/createBooks';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serialize(invalidBookList));
        RestContext.request = req;
        
        Test.startTest();
        // Call the REST resource method
        String response = BookCreationAPI.doPost();
        Test.stopTest();
        
        // Verify the expected error response
        System.assertEquals('Book ID required for creating a Record', response);
    }

    // Test method to validate handling of invalid JSON input
    @isTest
    static void testInvalidJSONInput() {
        // Simulate REST request with invalid JSON
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/createBooks';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('Invalid JSON');
        RestContext.request = req;
        
        Test.startTest();
        // Call the REST resource method
        String response = BookCreationAPI.doPost();
        Test.stopTest();
        
        // Verify the expected error response
        System.assert(response.contains('Error parsing JSON input'));
    }

    
}