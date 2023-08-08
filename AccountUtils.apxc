public class AccountUtils {
    /**
     ****** Updated Code for Question 1******
     * This method filters the provided list of account IDs and returns the accounts with the "Customer" record type
     * and Processed__c = false. If no accounts with the "Customer" record type and Processed__c = false are found,
     * it returns an empty list.
     *
     * @param accountIds List of Account IDs to be filtered.
     * @return List of accounts with the "Customer" record type and Processed__c = false.
     */
    public static List<Account> getCustomerAccounts(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return new List<Account>();
        }

        List<Account> customerAccounts = new List<Account>();
        for (Account acc : [
            SELECT Id, Name, RecordTypeId, RecordType.Name,Processed__c
            FROM Account
            WHERE Id IN :accountIds AND Processed__c = false AND RecordType.Name = 'Customer'
        ]) {
            customerAccounts.add(acc);
        }

        return customerAccounts;
    }
}
