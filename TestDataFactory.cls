@isTest
public class TestDataFactory {
    public static List<Account> createTestAccounts() {
        List<Account> testAccounts = new List<Account>();
		Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Customer')?.getRecordTypeId();

        // Create accounts with Customer record type and Processed__c = false
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name='Test Account ' + i, RecordTypeId=recordTypeId, Processed__c=false);
            testAccounts.add(acc);
        }

        // Create accounts with other record types and Processed__c = false
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name='Test Customer Account ' + (i + 5), Processed__c=false);
            testAccounts.add(acc);
        }

        return testAccounts;
    }

    public static List<Account> createNonCustomerAccounts() {
        List<Account> testAccounts = new List<Account>();
        RecordType nonCustomerRecordType = [SELECT Id, Name FROM RecordType WHERE SObjectType = 'Account' AND Name != 'Customer' LIMIT 1];

        // Create accounts with Non-Customer record type and Processed__c = false
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name='Non-Customer Account ' + i, RecordTypeId=nonCustomerRecordType.Id, Processed__c=false);
            testAccounts.add(acc);
        }

        // Create accounts with other record types and Processed__c = false
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name='Test Account ' + (i + 5), Processed__c=false);
            testAccounts.add(acc);
        }

        return testAccounts;
    }
}