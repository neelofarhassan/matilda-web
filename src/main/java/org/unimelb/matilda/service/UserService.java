package org.unimelb.matilda.service;
 
import java.util.List;

import org.unimelb.matilda.model.User;
 
 
public interface UserService {
     
    User findById(int id);
     
    User findBySSO(String sso);
    
    void saveUser(User user);
    
    void updateUser(User user);
    
    void updateUserStatus(User user);
     
    void deleteUserBySSO(String sso);
    
    List<User> findAllUsers(); 
    
    List<User> findUsersByStatus(String status);
         
    boolean isUserSSOUnique(Integer id, String sso);
 
}

