@isTest
public class ITCompanyDataFactory {
    
    public static Client__c oneClient (Boolean isInsert, String name){
        Client__c firstclient = new Client__c(
        	Name = name
        );
        if (isInsert) {
        	insert firstclient;
        }
        return firstclient;
    }
    
    public static Developer__c oneDev (Boolean isInsert, String name, Integer totBillble){
        Developer__c firstDev = new Developer__c(
        	Name = name, 
            TotalBillableProjects__c = totBillble
        );
        if (isInsert) {
        	insert firstDev;
        }
        return firstDev;
    }
    
    public static Project__c oneProject(Boolean isInsert, String name, Id clientId, Boolean active, Boolean isBilliable){
        Project__c firstProject = new Project__c(
            Name = name, 
            Client__c = clientId, 
            Active__c = active, 
            IsBillable__c = isBilliable
        );
        if (isInsert) {
        	insert firstProject;
        }
        return firstProject;
    }
    
    public static Project__c secProject(Boolean isInsert, String name, Id clientId, Boolean active){
        Project__c secondProject = new Project__c(
            Name = name, 
            Client__c = clientId, 
            Active__c = active
        );
        if (isInsert) {
        	insert secondProject;
        }
        return secondProject;
    }
    
    public static Project_Assignment__c oneProjAssign(Boolean isInsert, String name, Id projectId, Id devId){
        Project_Assignment__c firstProjAssign = new Project_Assignment__c(
            Name = name, 
            Project__c = projectId, 
            Developer__c = devId
        );
        if (isInsert) {
        	insert firstProjAssign;
        }
        return firstProjAssign;
    }

}