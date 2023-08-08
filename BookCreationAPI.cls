@RestResource(urlMapping='/createBooks/*')
global with sharing class BookCreationAPI {
    
    @HttpPost
    global static String doPost() {
        List<Book__c> booksToInsert = new List<Book__c>();
        
        // Deserialize the JSON input into a list of BookInfo objects
        List<BookInfo> bookList;
        try {
            bookList = (List<BookInfo>) JSON.deserialize(RestContext.request.requestBody.tostring(), List<BookInfo>.class);
        } catch (Exception ex) {
            return 'Error parsing JSON input: ' + ex.getMessage();
        }
        
        // Iterate through the deserialized data and create Book__c records
        for (BookInfo bookInfo : bookList) {
            
            if(String.isBlank(bookInfo.Id)){
                return 'Book ID required for creating a Record' ;
            }
            
            // Instantiate the Book__c object
            booksToInsert.add(new Book__c(
                Id__c = bookInfo.Id,
                Title__c = bookInfo.title,
                Author__c = bookInfo.author,
                Published_Year__c = bookInfo.published_year
            ));

        }
        
        // Insert the records in Salesforce
        try {
            upsert booksToInsert Id__c;
            return 'Books created successfully';
        } catch (DmlException ex) {
            return 'Error inserting records: ' + ex.getMessage();
        }
    }
    
    // Wrapper class to represent the JSON data structure
    public class BookInfo {
        public String Id;
        public String title;
        public String author;
        public String published_year;
    }
}