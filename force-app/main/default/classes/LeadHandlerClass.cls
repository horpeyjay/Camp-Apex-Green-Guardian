public with sharing class LeadHandlerClass {
    public static void createTaskForlead(List<Lead> leadList){
        /**
         * When a Lead record is created, automatically create a related Task record for the Lead owner with the following information
         */
        List<Task> taskList = new List<Task>();
        if(!leadList.isEmpty()){
            for(Lead l : leadList){
                Task t = new Task();
                try{
                    if(l.OwnerId != null){
                        t.OwnerId = l.OwnerId;
                        t.Subject = 'Schedule Demo Call';
                        t.WhoId = l.Id;
                        t.ActivityDate = System.today() + 14;
    
                        taskList.add(t);
                    }
                }catch(Exception ex){
                    l.addError('Somethning went wrong while creating task => ' + ex.getMessage());
                }
            }
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}