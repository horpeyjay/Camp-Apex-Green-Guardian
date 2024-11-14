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
}