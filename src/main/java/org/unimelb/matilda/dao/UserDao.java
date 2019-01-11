package org.unimelb.matilda.dao;
import java.util.List;

import org.unimelb.matilda.model.User;
 
 
public interface UserDao {
 
    User findById(int id);
     
    User findBySSO(String sso);
     
    void save(User user);
    
    void updateEntity(User user);
    
    User UpdateUserStatus(User user);
    
    void deleteBySSO(String sso);
     
    List<User> findAllUsers();
    
    List<User> findUsersByStatus(String status);
}