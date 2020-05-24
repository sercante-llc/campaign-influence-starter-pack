User u = [SELECT Id, UserPermissionsMarketingUser FROM User WHERE Id = :UserInfo.getUserId()];
u.UserPermissionsMarketingUser = true;
update u;