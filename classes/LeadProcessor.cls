/**
 * @description Hello World
 */
public class LeadProcessor implements Database.Batchable<sObject>{
    public Database.QueryLocator Start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT LeadSource, Id, Name FROM Lead]);
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        List<Lead> updatedLeadList = new List<Lead>();
        for (Lead l : scope) {
            l.LeadSource = 'Dreamforce';

            updatedLeadList.add(l);
        }
        update updatedLeadList;
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('Finished updating leads');
          AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
         System.debug('Finished updating leads' + job);
    }
    /** THis is the test **/
  
}