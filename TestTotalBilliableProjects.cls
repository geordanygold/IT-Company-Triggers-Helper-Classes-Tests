@isTest
public class TestTotalBilliableProjects {
    
    @isTest
    public static void testTotBilliableProjesInsert(){
        
        Client__c firstClient = ITCompanyDataFactory.oneClient(false, 'Client11');
        insert firstClient;
        
        Project__c firstProject = ITCompanyDataFactory.oneProject(false, 'Project1', firstClient.Id, true, true);
        insert firstProject;

        Developer__c firstDev = ITCompanyDataFactory.oneDev(false, 'Developer1', 1);
        insert firstDev;
        
        Project_Assignment__c firstProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign1', firstProject.Id, firstDev.Id);
        insert firstProjAssign;
        
        Project__c secondProject = ITCompanyDataFactory.oneProject(false, 'Project2', firstClient.Id, true, true);
        insert secondProject;
        
        Project_Assignment__c secondProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign2', secondProject.Id, firstDev.Id);
        insert secondProjAssign;
 
        
        User u1 = [SELECT Id FROM User WHERE Alias='aloja'];
        
        Test.startTest();
        
        Project__c thirdProject = ITCompanyDataFactory.oneProject(false, 'Project3', firstClient.Id, true, true);
        insert thirdProject;

        Project_Assignment__c thirdProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign3', thirdProject.Id, firstDev.Id);
        insert thirdProjAssign; 
      
        System.runAs ( u1 ){
            firstDev = [SELECT TotalBillableProjects__c FROM Developer__c WHERE Id =: firstDev.Id];            

        }        
        Test.stopTest();             
        system.assertEquals(3, firstDev.TotalBillableProjects__c);

    }
    
    @isTest
    public static void testTotBilliableProjesUpdate(){
        
        Client__c firstClient = ITCompanyDataFactory.oneClient(false, 'Client11');
        insert firstClient;
        
        Project__c firstProject = ITCompanyDataFactory.oneProject(false, 'Project1', firstClient.Id, true, true);
        insert firstProject;

        Developer__c firstDev = ITCompanyDataFactory.oneDev(false, 'Developer1', 1);
        insert firstDev;
        
        Project_Assignment__c firstProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign1', firstProject.Id, firstDev.Id);
        insert firstProjAssign;
        
        Project__c secondProject = ITCompanyDataFactory.oneProject(false, 'Project2', firstClient.Id, true, true);
        insert secondProject;
        
        Project_Assignment__c secondProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign2', secondProject.Id, firstDev.Id);
        insert secondProjAssign;
 
        
        User u1 = [SELECT Id FROM User WHERE Alias='aloja'];
        
        Test.startTest();
        
        secondProject.IsBillable__c = FALSE;
        update secondProject;
      
        System.runAs ( u1 ){
            firstDev = [SELECT TotalBillableProjects__c FROM Developer__c WHERE Id =: firstDev.Id];            

        }        
        Test.stopTest();             
        system.assertEquals(1, firstDev.TotalBillableProjects__c);

    }
    
    
    @isTest
    public static void testTotBilliableProjesDelete(){
        
        Client__c firstClient = ITCompanyDataFactory.oneClient(false, 'Client11');
        insert firstClient;
        
        Project__c firstProject = ITCompanyDataFactory.oneProject(false, 'Project1', firstClient.Id, true, true);
        insert firstProject;

        Developer__c firstDev = ITCompanyDataFactory.oneDev(false, 'Developer1', 1);
        insert firstDev;
        
        Project_Assignment__c firstProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign1', firstProject.Id, firstDev.Id);
        insert firstProjAssign;
        
        Project__c secondProject = ITCompanyDataFactory.oneProject(false, 'Project2', firstClient.Id, true, true);
        insert secondProject;
        
        Project_Assignment__c secondProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign2', secondProject.Id, firstDev.Id);
        insert secondProjAssign;
 
        
        User u1 = [SELECT Id FROM User WHERE Alias='aloja'];
        
        Test.startTest();

        delete secondProjAssign;
      
        System.runAs ( u1 ){
            firstDev = [SELECT TotalBillableProjects__c FROM Developer__c WHERE Id =: firstDev.Id];            

        }        
        Test.stopTest();             
        system.assertEquals(1, firstDev.TotalBillableProjects__c);

    }
    
    @isTest
    public static void changeDev(){
        
        Client__c firstClient = ITCompanyDataFactory.oneClient(false, 'Client11');
        insert firstClient;
        
        Project__c firstProject = ITCompanyDataFactory.oneProject(false, 'Project1', firstClient.Id, true, true);
        insert firstProject;

        Developer__c firstDev = ITCompanyDataFactory.oneDev(false, 'Developer1', 1);
        insert firstDev;
        
        Developer__c secondDev = ITCompanyDataFactory.oneDev(false, 'Developer2', 1);
        insert secondDev;
        
        Project_Assignment__c firstProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign1', firstProject.Id, firstDev.Id);
        insert firstProjAssign;
        
        Project__c secondProject = ITCompanyDataFactory.oneProject(false, 'Project2', firstClient.Id, true, true);
        insert secondProject;
        
        Project_Assignment__c secondProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign2', secondProject.Id, firstDev.Id);
        insert secondProjAssign;
 
        
        User u1 = [SELECT Id FROM User WHERE Alias='aloja'];
        
        Test.startTest();
		
        firstProjAssign.Developer__c = secondDev.Id;
        update firstProjAssign;
 
        System.runAs ( u1 ){
            firstDev = [SELECT TotalBillableProjects__c FROM Developer__c WHERE Id =: firstDev.Id];            

        }        
        Test.stopTest();             
        system.assertEquals(1, firstDev.TotalBillableProjects__c);

    }

}