@isTest(SeeAllData=false)
public class AccountUtilsTest {

    @testSetup
    static void setupTestData() {
        List<Account> testAccounts = TestDataFactory.createTestAccounts();
        insert testAccounts;
    }

    @isTest
    static void testGetCustomerAccounts_Positive() {
        // Start the test transaction
        Test.startTest();

        // Get test data account IDs
        List<Account> testAccounts = [SELECT Id FROM Account WHERE Processed__c=false];
        List<Id> testAccountIds = new List<Id>();
        for (Account acc : testAccounts) {
            testAccountIds.add(acc.Id);
        }

        // Call the method to be tested
        List<Account> customerAccounts = AccountUtils.getCustomerAccounts(testAccountIds);

        // Assert that customerAccounts contains only customer accounts with Processed__c = false
        for (Account acc : customerAccounts) {
            System.assert(acc.RecordType.Name == 'Customer', 'Returned account must have "Customer" Record Type');
            System.assert(!acc.Processed__c, 'Returned account Processed__c must be false');
        }

        // Stop the test transaction
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerAccounts_Negative() {
        // Start the test transaction
        Test.startTest();

        // Create test data with record type of account other than "Customer"
        List<Account> testAccounts = TestDataFactory.createNonCustomerAccounts();
        insert testAccounts;

        // Get test data account IDs
        List<Id> testAccountIds = new List<Id>();
        for (Account acc : testAccounts) {
            testAccountIds.add(acc.Id);
        }

        // Call the method to be tested
        List<Account> customerAccounts = AccountUtils.getCustomerAccounts(testAccountIds);

        // Assert that customerAccounts is empty since there are no "Customer" record type accounts
        System.assert(customerAccounts.isEmpty(), 'No "Customer" accounts should be returned');

        // Stop the test transaction
        Test.stopTest();
    }

    @isTest
    static void testGetCustomerAccounts_NullInput() {
        // Start the test transaction
        Test.startTest();

        // Call the method to be tested with null input
        List<Account> customerAccounts = AccountUtils.getCustomerAccounts(null);

        // Assert that customerAccounts is empty when provided with null input
        System.assert(customerAccounts.isEmpty(), 'No accounts should be returned when provided with null input');

        // Stop the test transaction
        Test.stopTest();
    }
}