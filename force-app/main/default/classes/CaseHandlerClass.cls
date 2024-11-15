public with sharing class CaseHandlerClass {
    public static void triageNewCases(List<Case> caseList){
        List<Group> groupMap = new List<Group>([Select Id, DeveloperName From Group where Type = 'Queue' and DeveloperName In ('Rapid_Response_Team', 'General_Support')]);
        Map<String, Id> devNameMap = new Map<String,Id>();
        for(Group g : groupMap){
            devNameMap.put(g.DeveloperName,g.Id);
        }
        if(!caseList.isEmpty()){
            for(Case ca : caseList){
                if(ca.Priority == 'High'){
                    ca.OwnerId = devNameMap.get('Rapid_Response_Team');
                    
                }else{
                    ca.OwnerId = devNameMap.get('General_Support');
                }
            }
        }
    }

    public static void preventDelete(List<Case> casesToDelete){
        if(!casesToDelete.isEmpty()){
            for(Case c : casesToDelete){
                if(c.IsClosed == false){
                    c.addError('You cannot delete an open case.');
                }
            }
        }
    }
}