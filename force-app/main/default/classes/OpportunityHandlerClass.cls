public with sharing class OpportunityHandlerClass {
    public static void renewalOpportunity(List<Opportunity> oppList, Map<Id, Opportunity> oppMap){
        List<Opportunity> oppsToInsert = new List<Opportunity>();
        Map<Id, Decimal> oppAmountMap = new Map<Id, Decimal>();
        Set<Id> accIds = new Set<Id>();
        if(!oppList.isEmpty()){
            for(Opportunity o : oppList){
                Opportunity oldOpp = oppMap.get(o.Id);
                if(o.StageName == 'Closed Won' && o.StageName != oldOpp.StageName){
                    accIds.add(o.AccountId);     
                    Opportunity newOpp = new Opportunity();
                    newOpp.Name = 'Renewal for ' + o.Account.Name;
                    newOpp.CloseDate = Date.today().addMonths(12);
                    newOpp.StageName = 'Prospecting';
                    newOpp.AccountId = o.AccountId;
                    newOpp.OwnerId = o.OwnerId;
                    newOpp.Amount = o.Amount;
                    oppsToInsert.add(newOpp);
                }
            }
        }

        if(!oppsToInsert.isEmpty()){
            insert oppsToInsert;
        }
    }

    public static void defaultOppName(List<Opportunity> oppList){
        Set<Id> accIds = new Set<Id>();
        if(!oppList.isEmpty()){
            String oppName;
            
            for(Opportunity opp : oppList){
                if(opp.CloseDate != null && opp.AccountId != null){
                    Integer closeYear = opp.CloseDate.year();
                    oppName = String.valueOf(closeYear);
                    accIds.add(opp.AccountId);
                }
            }
        }

        if (!accIds.isEmpty()) {
            // Fetch Account details and store them in a map
            Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN :accIds]);

            for (Opportunity opp : oppList) {
                if (opp.CloseDate != null && opp.AccountId != null) {
                    // Generate the name based on the account and close year
                    Integer closeYear = opp.CloseDate.year();
                    Account acc = accMap.get(opp.AccountId);
                    
                    if (acc != null) {
                        opp.Name = String.valueOf(closeYear) + ' ' + acc.Name + ' Opportunity';
                    }
                }
            }
        }
    }
}